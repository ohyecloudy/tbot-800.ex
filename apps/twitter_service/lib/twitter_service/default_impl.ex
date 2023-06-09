defmodule TwitterService.DefaultImpl do
  use Tesla

  alias TwitterService.Impl
  alias TwitterService.DefaultImpl.Oauth1

  @behaviour Impl

  @spec update_status(String.t(), Impl.oauth()) :: :ok | {:error, any}
  def update_status(tweet, oauth) do
    case client(oauth) |> Tesla.post("/tweets", %{text: tweet}) do
      {:ok, %{status: status}} when status >= 200 and status < 300 ->
        :ok

      other ->
        {:error, other}
    end
  end

  defp client(oauth) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.twitter.com/2"},
      Tesla.Middleware.JSON,
      {Oauth1, oauth}
    ]

    Tesla.client(middleware)
  end
end
