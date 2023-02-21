defmodule Tbot800.Twitter.Impl do
  alias Tbot800.Twitter.OAuth

  @callback tweet(OAuth.t(), String.t()) :: :ok
end
