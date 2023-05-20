defmodule TwitterService do
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

    :hackney.post(
      url,
      [header],
      {:form, req_params}
    )
  end
end
