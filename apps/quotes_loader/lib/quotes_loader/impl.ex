defmodule QuotesLoader.Impl do
  @callback load_file!(String.t()) :: list
  @callback load_url!(String.t()) :: list
end
