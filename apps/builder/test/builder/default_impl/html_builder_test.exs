defmodule Builder.DefaultImpl.HtmlBuilderTest do
  use ExUnit.Case

  alias Builder.DefaultImpl.HtmlBuilder

  test "build html" do
    assert HtmlBuilder.build("book_quote_bot", "내용1, 내용2", "GA4") == """
           <!DOCTYPE html>
           <html lang="en">
           <head>
           <meta charset="utf-8">
           <meta content="width=device-width, initial-scale=1.0" name="viewport">
           <meta content="summary" name="twitter:card">
           <meta content="전체 인용구" name="twitter:title">
           <meta content="@book_quote_bot" name="twitter:creator">
           <meta content="트위터 내용 제한으로 트윗에 포함되지 못한 전체 인용구를 확인하세요" name="twitter:description">
           <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
           <!-- Google tag (gtag.js) -->
           <script async src="https://www.googletagmanager.com/gtag/js?id=GA4"></script>
           <script>
           window.dataLayer = window.dataLayer || [];
           function gtag(){dataLayer.push(arguments);}
           gtag('js', new Date());

           gtag('config', 'GA4');
           </script>
           <title>인용구</title>
           </head>
           <body>
           <div class="container">
           <div class="row">
           <div class="col-md-6 col-md-offset-3">
           <div class="page-header">
           <h1>인용구 <small><a href="http://twitter.com/@book_quote_bot" target="blank">@book_quote_bot</a></small></h1>
           </div>
           </div>
           </div>
           <div class="row">
           <div class="col-md-6 col-md-offset-3">
           <p class="lead">내용1, 내용2</p>
           </div>
           </div>
           </div>
           </body>
           </html>
           """
  end
end
