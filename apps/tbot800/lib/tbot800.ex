defmodule Tbot800 do
  alias Tbot800.DefaultImpl

  @behaviour Tbot800.Impl

  @spec random_tweet(String.t(), String.t(), String.t(), String.t(), [String.t()]) :: :ok
  def random_tweet(consumer_key, consumer_secret, access_token, access_token_secret, contents) do
    current_impl().random_tweet(
      consumer_key,
      consumer_secret,
      access_token,
      access_token_secret,
      contents
    )
  end

  defp current_impl() do
    DefaultImpl
  end
end
