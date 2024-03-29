defmodule Tbot800.DefaultImpl.Twitter.DefaultImpl do
  require Logger
  alias Tbot800.DefaultImpl.OAuth

  @behaviour Tbot800.DefaultImpl.Twitter.Impl

  @spec tweet(OAuth.t(), String.t()) :: :ok
  def tweet(oauth, content) do
    oauth = oauth |> Map.from_struct() |> Map.to_list()
    Sentry.Context.add_breadcrumb(message: content)

    case TwitterService.update_status(content, oauth) do
      :ok ->
        :ok

      {:error, {:ok, %{body: %{"detail" => detail}}}} = e ->
        Logger.error(inspect(e))
        Sentry.capture_message(detail, extra: e, fingerprint: detail)
        :ok

      e ->
        Logger.error(inspect(e))
        Sentry.capture_message(inspect(e))
        :ok
    end
  end
end
