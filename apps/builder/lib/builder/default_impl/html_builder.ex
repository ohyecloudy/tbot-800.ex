defmodule Builder.DefaultImpl.HtmlBuilder do
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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
  <!-- Google tag (gtag.js) -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=<%= @ga4_measurement_id %>"></script>
  <script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', '<%= @ga4_measurement_id %>');
  </script>
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
  def build(twitter_account, content, ga4_measurement_id) do
    EEx.eval_string(@template,
      assigns: [
        twitter_account: twitter_account,
        content: content,
        ga4_measurement_id: ga4_measurement_id,
        twitter_card_description: "트위터 내용 제한으로 트윗에 포함되지 못한 전체 인용구를 확인하세요"
      ]
    )
  end
end
