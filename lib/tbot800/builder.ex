defmodule Tbot800.Builder do
  @moduledoc """
  인용구 소스를 입력으로 받아 HTML 페이지와 읽어서 바로 트윗할 데이터를 만든다.
  """

  @tweet_max_length 140

  @spec build_tweet_item(String.t() | nil, String.t(), String.t()) :: String.t()
  def build_tweet_item(source, item, web_link) do
    item_with_source = "#{item}#{source_suffix(source)}"

    if String.length(item_with_source) > @tweet_max_length do
      link_length = String.length(web_link)

      # 1: 빈 칸
      # 3: ... 줄임
      item_length =
        @tweet_max_length -
          link_length -
          1 -
          source_reserved_length(source) -
          3

      "#{String.slice(item, 0, item_length)}...#{source_suffix(source)} #{web_link}"
    else
      item_with_source
    end
  end

  defp source_suffix(source) do
    if source != nil and String.length(source) > 0 do
      " <#{source}>"
    else
      ""
    end
  end

  defp source_reserved_length(source) do
    if source != nil and String.length(source) > 0 do
      # <, >, 앞에 빈 칸
      String.length(source) + 3
    else
      0
    end
  end
end
