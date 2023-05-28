defmodule Tbot800.DefaultImpl.Twitter.DefaultImpl do
  require Logger
  alias Tbot800.DefaultImpl.OAuth

  @behaviour Tbot800.DefaultImpl.Twitter.Impl

  @spec tweet(OAuth.t(), String.t()) :: :ok
  def tweet(oauth, content) do
    oauth = oauth |> Map.from_struct() |> Map.to_list()

    case TwitterService.update_status(content, oauth) do
      :ok ->
        :ok

      e ->
        Logger.error(insepct(e))
        Sentry.capture_message(e, extra: %{tweet: content})
        :ok
    end
  end
end
