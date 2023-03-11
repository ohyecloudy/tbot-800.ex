defmodule Tbot800.DefaultImpl do
  alias Tbot800.DefaultImpl.Twitter
  alias Tbot800.DefaultImpl.Twitter.OAuth

  @behaviour Tbot800.Impl

  # TODO OAuth를 여기서 노출하면 안 된다

  @spec random_tweet(String.t(), String.t(), String.t(), String.t(), [String.t()]) :: :ok
  def random_tweet(consumer_key, consumer_secret, access_token, access_token_secret, contents) do
    Twitter.tweet(
      OAuth.new(consumer_key, consumer_secret, access_token, access_token_secret),
      Enum.random(contents)
    )

    :ok
  end
end
