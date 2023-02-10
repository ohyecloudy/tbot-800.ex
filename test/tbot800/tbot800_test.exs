defmodule Tbot800.Tbot800Test do
  use ExUnit.Case

  test "build - happy path" do
    Tbot800.build(
      fn ->
        [
          %{origin: "a", quotations: [String.duplicate("가", 140), "q2"]},
          %{origin: "b", quotations: ["q3"]}
        ]
      end,
      "testbot",
      "http://ohrepos.github.io/pquotes-repo/quotes/",
      fn tweet_items ->
        assert tweet_items == [
                 "[",
                 "\n  ",
                 "\"",
                 "가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가\
가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가\
가가가가가가가가가가가가가가가가가가가가가가가가... \
http://ohrepos.github.io/pquotes-repo/quotes/a9ede5dcf6fb7132f3ef37c6af29abc76dacf9ef.html",
                 "\"",
                 ",",
                 "\n  ",
                 "\"",
                 "q2 <a>",
                 "\"",
                 ",",
                 "\n  ",
                 "\"",
                 "q3 <b>",
                 "\"",
                 "\n",
                 "]"
               ]
      end,
      fn -> :ok end,
      fn
        "a9ede5dcf6fb7132f3ef37c6af29abc76dacf9ef.html", content ->
          assert content ==
                   "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<meta charset=\"utf-8\">\n<meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\">\n<meta content=\"summary\" name=\"twitter:card\">\n<meta content=\"전체 인용구\" name=\"twitter:title\">\n<meta content=\"@testbot\" name=\"twitter:creator\">\n<meta content=\"트위터 내용 제한으로 트윗에 포함되지 못한 전체 인용구를 확인하세요\" name=\"twitter:description\">\n<link href=\"http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css\" rel=\"stylesheet\">\n<title>인용구</title>\n</head>\n<body>\n<div class=\"container\">\n<div class=\"row\">\n<div class=\"col-md-6 col-md-offset-3\">\n<div class=\"page-header\">\n<h1>인용구 <small><a href=\"http://twitter.com/@testbot\" target=\"blank\">@testbot</a></small></h1>\n</div>\n</div>\n</div>\n<div class=\"row\">\n<div class=\"col-md-6 col-md-offset-3\">\n<p class=\"lead\">가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가 <a></p>\n</div>\n</div>\n</div>\n</body>\n</html>\n"

          :ok

        "d3b33a8efd4604ffee28e18b6cd8d38e40eaee40.html", content ->
          assert content ==
                   "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<meta charset=\"utf-8\">\n<meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\">\n<meta content=\"summary\" name=\"twitter:card\">\n<meta content=\"전체 인용구\" name=\"twitter:title\">\n<meta content=\"@testbot\" name=\"twitter:creator\">\n<meta content=\"트위터 내용 제한으로 트윗에 포함되지 못한 전체 인용구를 확인하세요\" name=\"twitter:description\">\n<link href=\"http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css\" rel=\"stylesheet\">\n<title>인용구</title>\n</head>\n<body>\n<div class=\"container\">\n<div class=\"row\">\n<div class=\"col-md-6 col-md-offset-3\">\n<div class=\"page-header\">\n<h1>인용구 <small><a href=\"http://twitter.com/@testbot\" target=\"blank\">@testbot</a></small></h1>\n</div>\n</div>\n</div>\n<div class=\"row\">\n<div class=\"col-md-6 col-md-offset-3\">\n<p class=\"lead\">q2 <a></p>\n</div>\n</div>\n</div>\n</body>\n</html>\n"

          :ok

        "f60bb77781df03c78b84661cf0ec8b49db7c8dd2.html", content ->
          assert content ==
                   "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<meta charset=\"utf-8\">\n<meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\">\n<meta content=\"summary\" name=\"twitter:card\">\n<meta content=\"전체 인용구\" name=\"twitter:title\">\n<meta content=\"@testbot\" name=\"twitter:creator\">\n<meta content=\"트위터 내용 제한으로 트윗에 포함되지 못한 전체 인용구를 확인하세요\" name=\"twitter:description\">\n<link href=\"http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css\" rel=\"stylesheet\">\n<title>인용구</title>\n</head>\n<body>\n<div class=\"container\">\n<div class=\"row\">\n<div class=\"col-md-6 col-md-offset-3\">\n<div class=\"page-header\">\n<h1>인용구 <small><a href=\"http://twitter.com/@testbot\" target=\"blank\">@testbot</a></small></h1>\n</div>\n</div>\n</div>\n<div class=\"row\">\n<div class=\"col-md-6 col-md-offset-3\">\n<p class=\"lead\">q3 <b></p>\n</div>\n</div>\n</div>\n</body>\n</html>\n"

          :ok
      end
    )
  end
end
