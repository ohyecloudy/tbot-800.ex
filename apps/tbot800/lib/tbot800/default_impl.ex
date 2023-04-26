defmodule Tbot800.DefaultImpl do
  alias Tbot800.DefaultImpl.Twitter
  alias Tbot800.DefaultImpl.OAuth

  @behaviour Tbot800.Impl

  defdelegate child_spec(opts), to: __MODULE__.Supervisor

  @spec random_tweet(String.t(), String.t(), String.t(), String.t(), [String.t()]) :: :ok
  def random_tweet(consumer_key, consumer_secret, access_token, access_token_secret, contents) do
    Twitter.tweet(
      OAuth.new(consumer_key, consumer_secret, access_token, access_token_secret),
      Enum.random(contents)
    )

    :ok
  end
end
