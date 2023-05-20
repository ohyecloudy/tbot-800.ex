defmodule TwitterService.DefaultImpl do
  alias TwitterService.Impl

  @behaviour Impl

  @spec update_status(String.t(), Impl.oauth()) :: :ok | {:error, any}
  def update_status(tweet, oauth) do
    url = "https://api.twitter.com/1.1/statuses/update.json"
    creds = OAuther.credentials(oauth)

    params =
      OAuther.sign(
        "post",
        url,
        [{"status", tweet}],
        creds
      )

    {header, req_params} = OAuther.header(params)

    case :hackney.post(
           url,
           [header],
           {:form, req_params}
         ) do
      {:ok, 200, _result} -> :ok
      {:ok, code, result} -> {:error, {code, result}}
      err -> err
    end
  end
end
