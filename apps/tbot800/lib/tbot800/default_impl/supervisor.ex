defmodule Tbot800.DefaultImpl.Supervisor do
  use Supervisor
  require Logger
  alias Tbot800.DefaultImpl.OAuth
  alias Tbot800.DefaultImpl.TwitterProcess

  def start_link(init_args) do
    Supervisor.start_link(__MODULE__, init_args, name: __MODULE__)
  end

  def init(_init_args) do
    tbot_accounts =
      case Application.fetch_env(:tbot800, :tbot_accounts) do
        {:ok, value} -> value
        :error -> raise "twitter account settings do not exist. see config/runtime.exs"
      end

    Logger.info("########################################")

    tbot_accounts
    |> Enum.each(fn account -> Logger.info("tweet items url: #{account[:tweet_items_url]}") end)

    Logger.info("########################################")

    children =
      tbot_accounts
      |> Enum.map(fn account ->
        url = account[:tweet_items_url]

        tweet_item_loader_func = fn ->
          QuotesLoader.load_url!(url)
        end

        oauth =
          OAuth.new(
            account[:consumer_key],
            account[:consumer_secret],
            account[:access_token],
            account[:access_token_secret]
          )

        [
          oauth: oauth,
          tweet_item_loader_func: tweet_item_loader_func,
          mode: :periodic,
          interval: account[:interval]
        ]
      end)
      |> Enum.with_index(fn args, index ->
        Supervisor.child_spec({TwitterProcess, args}, id: :"twitter_proc_#{index + 1}")
      end)

    Supervisor.init(children, strategy: :one_for_one)
  end
end
