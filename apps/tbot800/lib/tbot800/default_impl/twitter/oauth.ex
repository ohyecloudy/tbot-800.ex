defmodule Tbot800.DefaultImpl.Twitter.OAuth do
  # Tbot800.DefaultImpl.Twitter.DefaultImpl.OAuth 이게 맞는 것 같다
  # Tbot800.DefaultImpl.Twitter에서는 접근이 없음

  @type t :: %__MODULE__{
          consumer_key: String.t(),
          consumer_secret: String.t(),
          access_token: String.t(),
          access_token_secret: String.t()
        }
  defstruct consumer_key: "", consumer_secret: "", access_token: "", access_token_secret: ""

  @spec new(String.t(), String.t(), String.t(), String.t()) :: t
  def new(consumer_key, consumer_secret, access_token, access_token_secret) do
    %__MODULE__{
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      access_token: access_token,
      access_token_secret: access_token_secret
    }
  end
end
