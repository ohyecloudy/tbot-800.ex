Mox.defmock(TwitterBehaviourMock, for: Tbot800.Twitter.Impl)
Application.put_env(:tbot_800, :twitter_impl, TwitterBehaviourMock)

ExUnit.start()
