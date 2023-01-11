defmodule Tbot800.Builder do
  @moduledoc """
  인용구 소스를 입력으로 받아 HTML 페이지와 읽어서 바로 트윗할 데이터를 만든다.
  """

  alias Tbot800.Builder.{HtmlBuilder, TweetItemBuilder}

  @type quotation_list :: [String.t()]
  @type source ::
          %{quotations: quotation_list} | %{origin: String.t(), quotations: quotation_list}
  @type source_list :: [source]
  @type tweet_item :: String.t()
  @type webpage :: %{html: String.t(), html_filename: String.t()}

  @spec build(source_list, String.t(), String.t()) :: %{
          tweet_items: [tweet_item],
          webpages: [webpage]
        }
  def build(sources, twitter_account, base_url) do
    result =
      sources
      |> flatten()
      |> build_content()
      |> build_web_link(base_url)
      |> build_html(twitter_account)
      |> build_tweet_items()

    tweet_items =
      result
      |> Enum.map(&Map.fetch!(&1, :tweet))

    webpages =
      result
      |> Enum.map(&Map.take(&1, [:html, :html_filename]))

    %{tweet_items: tweet_items, webpages: webpages}
  end

  defp flatten(sources) do
    sources
    |> Enum.flat_map(fn
      %{quotations: quotations, origin: origin} ->
        Enum.map(quotations, fn q -> %{origin: origin, quotation: q} end)

      %{quotations: quotations} ->
        Enum.map(quotations, fn q -> %{origin: nil, quotation: q} end)
    end)
  end

  defp build_content(sources) do
    sources
    |> Enum.map(fn s ->
      content = content_builder(s)
      hash = calc_hash(content)

      s
      |> Map.put(:content, content)
      |> Map.put(:hash, hash)
    end)
  end

  defp build_web_link(sources, base_url) do
    base_url = String.trim_trailing(base_url, "/")

    sources
    |> Enum.map(fn %{hash: hash} = s ->
      s
      |> Map.put(:web_link, base_url <> "/#{hash}.html")
      |> Map.put(:html_filename, hash <> ".html")
    end)
  end

  defp build_html(sources, twitter_account) do
    sources
    |> Enum.map(fn %{content: content} = s ->
      Map.put(s, :html, HtmlBuilder.build(twitter_account, content))
    end)
  end

  defp build_tweet_items(sources) do
    sources
    |> Enum.map(fn %{quotation: q, origin: o, web_link: w} = s ->
      Map.put(s, :tweet, TweetItemBuilder.build(q, o, w))
    end)
  end

  defp calc_hash(content) do
    :crypto.hash(:sha, content) |> Base.encode16(case: :lower)
  end

  # TODO TweetItemBuilder와 중복 코드
  defp content_builder(%{origin: nil, quotation: q}), do: q
  defp content_builder(%{origin: o, quotation: q}), do: q <> " <#{o}>"
end
