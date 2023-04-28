Mox.defmock(TwitterBehaviourMock, for: Tbot800.DefaultImpl.Twitter.Impl)
Application.put_env(:tbot800, :twitter_impl, TwitterBehaviourMock)

ExUnit.start()
