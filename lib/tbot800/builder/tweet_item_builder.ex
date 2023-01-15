defmodule Tbot800.Builder.TweetItemBuilder do
  @moduledoc """
  인용구(quotation), 출처(origin), 인용구 페이지가 있는 웹링크를 입력으로
  받아서 140자 이내의 트윗이 가능한 아이템으로 만든다.
  """

  @tweet_max_length 140

  @spec build(String.t(), String.t() | nil, String.t()) :: String.t()
  def build(quotation, origin, web_link) do
    # TODO 한글, 영문에 따라 트윗 캐릭터 계산이 다르다. url도 다름
    # 그걸 반영해 최대한 많은 글자를 트윗하게 한다
    # https://developer.twitter.com/en/docs/counting-characters
    quotation_with_origin = "#{quotation}#{origin_suffix(origin)}"

    if String.length(quotation_with_origin) > @tweet_max_length do
      link_length = link_length(web_link)

      # 1: 빈 칸
      # 3: ... 줄임
      item_length = @tweet_max_length - link_length - 1 - 3

      "#{String.slice(quotation_with_origin, 0, item_length)}... #{web_link}"
    else
      quotation_with_origin
    end
  end

  defp origin_suffix(origin) do
    if origin != nil and String.length(origin) > 0 do
      " <#{origin}>"
    else
      ""
    end
  end

  defp link_length(_web_link) do
    # https://developer.twitter.com/en/docs/counting-characters
    # URLs: All URLs are wrapped in t.co links.
    # This means a URL’s length is defined by the transformedURLLength parameter
    # in the twitter-text configuration file. The current length of a URL in a Tweet is 23 characters,
    # even if the length of the URL would normally be shorter.

    23
  end
end
