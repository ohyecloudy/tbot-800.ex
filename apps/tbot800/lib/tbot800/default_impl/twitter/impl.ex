defmodule Tbot800.DefaultImpl.Twitter.Impl do
  alias Tbot800.DefaultImpl.Twitter.OAuth

  @callback tweet(OAuth.t(), String.t()) :: :ok
end
