defmodule Tbot800.DefaultImpl.OAuth do
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
