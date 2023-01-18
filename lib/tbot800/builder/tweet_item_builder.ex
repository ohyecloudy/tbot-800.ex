defmodule Tbot800.Builder.TweetItemBuilder do
  @moduledoc """
  인용구(quotation), 출처(origin), 인용구 페이지가 있는 웹링크를 입력으로
  받아서 140자 이내의 트윗이 가능한 아이템으로 만든다.
  """

  @tweet_max_length 280

  @spec build(String.t(), String.t() | nil, String.t()) :: String.t()
  def build(quotation, origin, web_link) do
    # TODO 한글, 영문에 따라 트윗 캐릭터 계산이 다르다. url도 다름
    # 그걸 반영해 최대한 많은 글자를 트윗하게 한다
    # https://developer.twitter.com/en/docs/counting-characters
    quotation_with_origin = "#{quotation}#{origin_suffix(origin)}"

    if rough_char_byte(quotation_with_origin) > @tweet_max_length do
      link_length = link_length(web_link)

      # 1: 빈 칸
      # 3: ... 줄임
      item_length = @tweet_max_length - link_length - 1 - 3

      #
      "#{take_string_by_byte(quotation_with_origin, item_length)}... #{web_link}"
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

  defp rough_char_byte(str) do
    # The first range covers characters across the Latin-1 code pages. (U+0000 - U+10FF).
    # https://developer.twitter.com/en/docs/counting-characters

    # 인용구는 영문 아니면 한글이다. twitter는 더 세분화된 byte 규칙을 가지고 있지만 러프하게 간다
    # latin-1 코드 페이지만 1byte로 취급하고 나머지는 2byte로 처리한다

    str
    |> String.graphemes()
    |> Enum.map(&calc_byte/1)
    |> Enum.sum()
  end

  # calc_byte 함수를 사용해 문자열에서 그만큼을 취한 substring을 구한다.
  defp take_string_by_byte(str, byte) do
    {taked, _} =
      str
      |> String.graphemes()
      |> Enum.reduce_while({[], byte}, fn c, acc = {taked, remain_bytes} ->
        b = calc_byte(c)
        remain_bytes = remain_bytes - b

        if remain_bytes < 0 do
          {:halt, acc}
        else
          {:cont, {[c | taked], remain_bytes}}
        end
      end)

    taked |> Enum.reverse() |> to_string()
  end

  defp calc_byte(c) do
    if "\u0000" <= c and c <= "\u10FF" do
      1
    else
      2
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
