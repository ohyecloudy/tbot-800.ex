defmodule Tbot800.Impl do
  @callback random_tweet(
              String.t(),
              String.t(),
              String.t(),
              String.t(),
              [String.t()]
            ) :: :ok
end
