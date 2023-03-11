defmodule Builder.DefaultImpl.TweetItemBuilderTest do
  use ExUnit.Case

  alias Builder.DefaultImpl.TweetItemBuilder

  test "build - length of quotation is equal less 140" do
    quotation = String.duplicate("가", 125)
    source = "somesource"
    web_link = "http://somelink.com"

    result = "가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가\
가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가\
가가가가가가가가가가가가가가가가가가가가가가가 <somesource>"

    assert TweetItemBuilder.build(quotation, source, web_link) == result
    assert String.length(result) <= 140
  end

  test "build - alphabet length of quotation is equal less 280" do
    quotation = String.duplicate("a", 280)
    source = "somesource"
    web_link = "http://somelink.com"

    result = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa... http://somelink.com"

    assert TweetItemBuilder.build(quotation, source, web_link) == result
  end

  test "build - alphabet ang hangul length of quotation is equal less 280" do
    quotation = String.duplicate("a", 140) |> String.graphemes() |> Enum.intersperse("한")
    source = "somesource"
    web_link = "http://somelink.com"

    result = "a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a\
한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한\
a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a한a\
한a한a한a한a한a한a한a한a... http://somelink.com"

    assert TweetItemBuilder.build(quotation, source, web_link) == result
  end

  test "build - length of quotation is great than 140" do
    quotation = String.duplicate("가", 140)
    source = "somesource"
    web_link = "http://somelink.com"

    result = "가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가\
가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가\
가가가가가가가가가가가가가가가가가가가가가가가가... http://somelink.com"

    assert TweetItemBuilder.build(quotation, source, web_link) == result
  end

  test "build - length of quotation is equal less 140 - empty source" do
    quotation = String.duplicate("가", 140)
    source = ""
    web_link = "http://somelink.com"

    assert TweetItemBuilder.build(quotation, source, web_link) == quotation
  end

  test "build - length of quotation is great than 140 - empty source" do
    quotation = String.duplicate("가", 141)
    source = nil
    web_link = "http://somelink.com"

    result = "가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가\
가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가\
가가가가가가가가가가가가가가가가가가가가가가가가... http://somelink.com"

    assert TweetItemBuilder.build(quotation, source, web_link) == result
  end
end
