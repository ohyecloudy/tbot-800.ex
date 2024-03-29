defmodule Tbot800.DefaultImpl.Twitter do
  require Logger

  alias Tbot800.DefaultImpl.OAuth
  alias Tbot800.DefaultImpl.Twitter.DefaultImpl

  @behaviour Tbot800.DefaultImpl.Twitter.Impl

  @spec tweet(OAuth.t(), String.t()) :: :ok
  def tweet(oauth, content) do
    Logger.info("try tweet: #{content}")
    current_impl().tweet(oauth, content)
  end

  defp current_impl() do
    Application.get_env(:tbot800, :twitter_impl, DefaultImpl)
  end
end
