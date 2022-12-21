defmodule Tbot800.BuilderTest do
  use ExUnit.Case
  alias Tbot800.Builder

  test "flatten/1" do
    assert Builder.flatten([%{quotations: ["q1", "q2"]}]) == [
       ~s("q2 <a>")
         %{origin: nil, quotation: "q1"},
             %{origin: nil, quotation: "q2"}
           ]

    assert Builder.flatten([%{origin: "a", quotations: ["q1", "q2"]}]) == [
             %{origin: "a", quotation: "q1"},
             %{origin: "a", quotation: "q2"}
           ]

    assert Builder.flatten([%{quotations: ["q1", "q2"]}, %{quotations: ["q3", "q4", "q5"]}]) == [
             %{origin: nil, quotation: "q1"},
             %{origin: nil, quotation: "q2"},
             %{origin: nil, quotation: "q3"},
             %{origin: nil, quotation: "q4"},
             %{origin: nil, quotation: "q5"}
           ]

    assert Builder.flatten([
             %{origin: "a", quotations: ["q1", "q2"]},
             %{origin: "b", quotations: ["q3"]}
           ]) == [
             %{origin: "a", quotation: "q1"},
             %{origin: "a", quotation: "q2"},
             %{origin: "b", quotation: "q3"}
           ]
  end

  test "build/3" do
    assert Builder.build(
             [
               %{origin: "a", quotations: [String.duplicate("가", 140), "q2"]},
               %{origin: "b", quotations: ["q3"]}
             ],
             "testbot",
             "http://ohrepos.github.io/pquotes-repo/quotes/"
           ) == %{
             tweet_items: ~s(["가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가\
가가가가가가가가가가가... <a> http://ohrepos.github.io/pquotes-repo/quotes/\
a9ede5dcf6fb7132f3ef37c6af29abc76dacf9ef.html", "q2 <a>", "q3 <b>"])
           }
  end
end
