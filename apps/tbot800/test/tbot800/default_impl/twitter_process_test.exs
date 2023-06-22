defmodule Tbot800.DefaultImpl.TwitterProcessTest do
  use ExUnit.Case

  alias Tbot800.DefaultImpl.TwitterProcess

  import Mox

  setup :set_mox_from_context
  setup :verify_on_exit!

  test "tweet next" do
    callback_pid = self()

    stub(TwitterBehaviourMock, :tweet, fn _oauth, content ->
      send(callback_pid, {:callback, content})

      :ok
    end)

    tweet_items = ["a", "b", "c"]
    tweet_item_loader_func = fn -> tweet_items end

    pid =
      start_supervised!(
        {TwitterProcess,
         [
           mode: :manual,
           interval: 0,
           oauth: "NOT USED",
           tweet_item_loader_func: tweet_item_loader_func
         ]}
      )

    TwitterProcess.tweet_next(pid)
    assert_receive {:callback, tweet}, 1000
    assert tweet in tweet_items
    tweet_items = List.delete(tweet_items, tweet)

    TwitterProcess.tweet_next(pid)
    assert_receive {:callback, tweet}, 1000
    assert tweet in tweet_items
    tweet_items = List.delete(tweet_items, tweet)

    TwitterProcess.tweet_next(pid)
    assert_receive {:callback, tweet}, 1000
    assert tweet in tweet_items
  end
end
