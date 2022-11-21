defmodule Tbot800.BuilderTest do
  use ExUnit.Case

  alias Tbot800.Builder

  test "build_tweet_item - length of quotation is equal less 140" do
    quotation = String.duplicate("가", 125)
    source = "somesource"
    web_link = "http://somelink.com"

    result =
      "가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가 <somesource>"

    assert Builder.build_tweet_item(quotation, source, web_link) == result
    assert String.length(result) <= 140
  end

  test "build_tweet_item - length of quotation is great than 140" do
    quotation = String.duplicate("가", 140)
    source = "somesource"
    web_link = "http://somelink.com"

    result =
      "가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가... <somesource> http://somelink.com"

    assert Builder.build_tweet_item(quotation, source, web_link) == result
    assert String.length(result) == 140
  end

  test "build_tweet_item - length of quotation is equal less 140 - empty source" do
    quotation = String.duplicate("가", 140)
    source = ""
    web_link = "http://somelink.com"

    assert Builder.build_tweet_item(quotation, source, web_link) == quotation
  end

  test "build_tweet_item - length of quotation is great than 140 - empty source" do
    quotation = String.duplicate("가", 141)
    source = nil
    web_link = "http://somelink.com"

    result =
      "가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가... http://somelink.com"

    assert Builder.build_tweet_item(quotation, source, web_link) == result
    assert String.length(result) == 140
  end
end
