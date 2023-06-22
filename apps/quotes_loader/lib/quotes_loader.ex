defmodule QuotesLoader do
  alias QuotesLoader.DefaultImpl

  @behaviour QuotesLoader.Impl

  @spec load_file!(String.t()) :: list
  def load_file!(path) do
    current_impl().load_file!(path)
  end

  @spec load_url!(String.t()) :: list
  def load_url!(url) do
    current_impl().load_url!(url)
  end

  defp current_impl() do
    DefaultImpl
  end
end
