defmodule TwitterService.Impl do
  @type oauth :: [
          consumer_key: String.t(),
          consumer_secret: String.t(),
          token: String.t(),
          token_secret: String.t()
        ]

  @callback update_status(String.t(), oauth) :: :ok | {:error, any}
end
