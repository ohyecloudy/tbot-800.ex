defmodule QuotesLoader.DefaultImpl do
  require Logger

  use Tesla

  alias QuotesLoader.Impl

  @behaviour Impl

  @spec load_file!(String.t()) :: list
  def load_file!(path) do
    Logger.info("load: #{path}")
    {tweet_items, _} = Code.eval_file(path)
    tweet_items
  end

  @spec load_url!(String.t()) :: list
  def load_url!(url) do
    %{status: 200, body: body} = Tesla.get!(url)
    {tweet_items, _} = Code.eval_string(body)
    tweet_items
  end
end
