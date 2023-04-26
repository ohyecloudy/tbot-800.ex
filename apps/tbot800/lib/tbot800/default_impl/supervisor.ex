defmodule Tbot800.DefaultImpl.Supervisor do
  use Supervisor
  require Logger

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
    |> Enum.each(fn account -> Logger.info("tweet items path: #{account[:tweet_items_path]}") end)

    Logger.info("########################################")

    children = []
    Supervisor.init(children, strategy: :one_for_one)
  end
end
