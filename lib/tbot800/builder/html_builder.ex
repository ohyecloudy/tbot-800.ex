defmodule Tbot800.Builder.HtmlBuilder do
  @template """
  <!DOCTYPE html>
  <html lang="en">
  <head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="summary" name="twitter:card">
  <meta content="전체 인용구" name="twitter:title">
  <meta content="@<%= @twitter_account %>" name="twitter:creator">
  <meta content="<%= @twitter_card_description %>" name="twitter:description">
  <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
  <title>인용구</title>
  </head>
  <body>
  <div class="container">
  <div class="row">
  <div class="col-md-6 col-md-offset-3">
  <div class="page-header">
  <h1>인용구 <small><a href="http://twitter.com/@<%= @twitter_account %>" target="blank">@<%= @twitter_account %></a></small></h1>
  </div>
  </div>
  </div>
  <div class="row">
  <div class="col-md-6 col-md-offset-3">
  <p class="lead"><%= @content %></p>
  </div>
  </div>
  </div>
  </body>
  </html>
  """

  require EEx

  @spec build(String.t(), String.t(), String.t()) :: String.t()
  def build(twitter_account, content, twitter_card_description) do
    EEx.eval_string(@template,
      assigns: [
        twitter_account: twitter_account,
        content: content,
        twitter_card_description: twitter_card_description
      ]
    )
  end
end
