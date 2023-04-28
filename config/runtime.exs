import Config

# 환경 변수로 설정한 계정 정보를 elixir config로 변환한다.
# 설정해야 할 환경 변수가 비어있으면 그 후 읽기를 중단한다.
# 예를 들어 ACCOUNT1_ 설정이 다 되어 있어야지 ACCOUNT2_ 설정 읽기를 시도한다.

accounts =
  Stream.iterate(1, &(&1 + 1))
  |> Stream.map(fn index ->
    [
      consumer_key: System.get_env("ACCOUNT#{index}_KEY"),
      consumer_secret: System.get_env("ACCOUNT#{index}_SECRET"),
      access_token: System.get_env("ACCOUNT#{index}_TOKEN"),
      access_token_secret: System.get_env("ACCOUNT#{index}_TOKEN_SECRET"),
      interval:
        String.to_integer(System.get_env("ACCOUNT#{index}_INTERVAL_MINUTE", "60")) * 1000 * 60,
      tweet_items_path: System.get_env("ACCOUNT#{index}_TWEET_ITEMS_PATH")
    ]
  end)
  |> Enum.take_while(fn account ->
    Enum.all?(Keyword.values(account), &(!is_nil(&1)))
  end)

if accounts != [] do
  config :tbot800, tbot_accounts: accounts
end

if sentry_dsn = System.get_env("SENTRY_DSN") do
  config :sentry, dsn: sentry_dsn
end

# 개발 편의가 필요할 때는 dev.secret.exs 같은 파일에 아래와 같은 설정을 넣어서 실행한다
# config :tbot800,
#   tbot_accounts: [
#     [
#       consumer_key: "consumer_key",
#       consumer_secret: "consumer_secret",
#       access_token: "access_token",
#       access_token_secret: "access_token_secret",
#       interval: 1000 * 60 * 60,
#       tweet_items_path: "pqoutes.exs"
#     ],
#     [
#       consumer_key: "consumer_key",
#       consumer_secret: "consumer_secret",
#       access_token: "access_token",
#       access_token_secret: "access_token_secret",
#       interval: 1000 * 60 * 60,
#       tweet_items_path: "book_quotes.exs"
#     ]
#   ]
