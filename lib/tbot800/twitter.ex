defmodule Tbot800.Twitter do
  alias Tbot800.Twitter.OAuth
  alias Tbot800.Twitter.DefaultImpl

  @behaviour Tbot800.Twitter.Impl

  @spec tweet(OAuth.t(), String.t()) :: :ok
  def tweet(oauth, content) do
    current_impl().tweet(oauth, content)
  end

  def current_impl() do
    Application.get_env(:tbot_800, :twitter_impl, DefaultImpl)
  end
end
