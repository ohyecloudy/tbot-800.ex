defmodule Tbot800.DefaultImpl.Twitter do
  alias Tbot800.DefaultImpl.OAuth
  alias Tbot800.DefaultImpl.Twitter.DefaultImpl

  @behaviour Tbot800.DefaultImpl.Twitter.Impl

  @spec tweet(OAuth.t(), String.t()) :: :ok
  def tweet(oauth, content) do
    current_impl().tweet(oauth, content)
  end

  defp current_impl() do
    Application.get_env(:tbot_800, :twitter_impl, DefaultImpl)
  end
end
