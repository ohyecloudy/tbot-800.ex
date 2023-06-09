defmodule TwitterService.DefaultImpl.Oauth1 do
  @behaviour Tesla.Middleware

  def call(env, next, oauth) do
    creds = OAuther.credentials(oauth)

    params =
      OAuther.sign(
        to_string(env.method),
        env.url,
        [],
        creds
      )

    {header, _req_params} = OAuther.header(params)

    env
    |> Tesla.put_headers([header])
    |> Tesla.run(next)
  end
end
