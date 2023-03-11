defmodule Tbot800Test do
  use ExUnit.Case
  doctest Tbot800

  import Mox

  setup :verify_on_exit!

  test "random_tweet - happy path" do
    tweet_items = ["a", "b", "c"]

    expect(TwitterBehaviourMock, :tweet, fn _oauth, content ->
      assert content in tweet_items

      :ok
    end)

    assert Tbot800.random_tweet(
             "consumer_key",
             "consumer_secret",
             "access_token",
             "access_token_secret",
             tweet_items
           ) == :ok
  end
end
