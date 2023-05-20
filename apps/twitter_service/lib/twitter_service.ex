defmodule TwitterService do
  alias TwitterService.Impl
  alias TwitterService.DefaultImpl

  @behaviour Impl

  @spec update_status(String.t(), Impl.oauth()) :: :ok | {:error, any}
  def update_status(tweet, oauth) do
    impl().update_status(tweet, oauth)
  end

  defp impl() do
    DefaultImpl
  end
end
