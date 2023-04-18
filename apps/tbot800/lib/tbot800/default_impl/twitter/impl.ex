defmodule Tbot800.DefaultImpl.Twitter.Impl do
  alias Tbot800.DefaultImpl.OAuth

  @callback tweet(OAuth.t(), String.t()) :: :ok
end
