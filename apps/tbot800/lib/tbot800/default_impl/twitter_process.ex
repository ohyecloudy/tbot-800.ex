defmodule Tbot800.DefaultImpl.TwitterProcess do
  require Logger

  alias Tbot800.DefaultImpl.Twitter
  alias __MODULE__.State

  use GenServer

  defmodule State do
    defstruct oauth: nil,
              tweet_item_loader_func: nil,
              mode: :periodic,
              interval: 0,
              remain_tweet_items: []
  end

  def start_link(args) when is_list(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def tweet_next(pid) do
    GenServer.cast(pid, :tweet_next)
  end

  @impl true
  def init(args) do
    state =
      %State{
        oauth: Keyword.fetch!(args, :oauth),
        tweet_item_loader_func: Keyword.fetch!(args, :tweet_item_loader_func),
        mode: Keyword.fetch!(args, :mode),
        interval: Keyword.fetch!(args, :interval)
      }
      |> refresh_remain_tweet_items([])

    case state.mode do
      :periodic ->
        Process.send_after(self(), :tick, state.interval)

      :manual ->
        :ok
    end

    {:ok, state}
  end

  @impl true
  def handle_cast(:tweet_next, state) do
    {:noreply, do_tweet(state)}
  end

  @impl true
  def handle_info(:tick, state) do
    Process.send_after(self(), :tick, state.interval)

    {:noreply, do_tweet(state)}
  end

  defp do_tweet(state) do
    [next_tweet | remain] = state.remain_tweet_items
    Twitter.tweet(state.oauth, next_tweet)

    refresh_remain_tweet_items(state, remain)
  end

  defp refresh_remain_tweet_items(state, remain) do
    if remain == [] do
      tweet_items = state.tweet_item_loader_func.()
      Logger.info("shuffle: #{Enum.count(tweet_items)} tweets")
      %{state | remain_tweet_items: Enum.shuffle(tweet_items)}
    else
      %{state | remain_tweet_items: remain}
    end
  end
end
