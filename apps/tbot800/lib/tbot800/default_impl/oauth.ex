defmodule Tbot800.DefaultImpl.OAuth do
  @type t :: %__MODULE__{
          consumer_key: String.t(),
          consumer_secret: String.t(),
          token: String.t(),
          token_secret: String.t()
        }
  defstruct consumer_key: "", consumer_secret: "", token: "", token_secret: ""

  @spec new(String.t(), String.t(), String.t(), String.t()) :: t
  def new(consumer_key, consumer_secret, token, token_secret) do
    %__MODULE__{
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      token: token,
      token_secret: token_secret
    }
  end
end
