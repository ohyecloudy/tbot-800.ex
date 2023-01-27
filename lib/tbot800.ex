defmodule Tbot800 do
  require Logger
  alias Tbot800.Builder

  def run() do
    {args, []} =
      OptionParser.parse!(System.argv(),
        strict: [
          source_path: :string,
          twitter_account: :string,
          html_host_base_url: :string,
          output_tweet_items_path: :string,
          output_html_root_dir: :string
        ]
      )

    build(
      args[:source_path],
      args[:twitter_account],
      args[:html_host_base_url],
      args[:output_tweet_items_path],
      args[:output_html_root_dir]
    )
  end

  def build(
        source_path,
        twitter_account,
        html_host_base_url,
        output_tweet_items_path,
        output_html_root_dir
      ) do
    Logger.info("build tweet items & html pages")

    Logger.info("=> read quote source file #{source_path}")
    {source_list, _} = Code.eval_file(source_path)

    Logger.info(
      "=> make tweet items & html pages account: #{twitter_account}, html_host_base_url: #{html_host_base_url}"
    )

    %{tweet_items: tweet_items, webpages: webpages} =
      Builder.build(source_list, twitter_account, html_host_base_url)

    Logger.info("=> write tweet items: #{output_tweet_items_path}")

    tweet_items
    |> Enum.to_list()
    |> inspect(limit: :infinity)
    |> Code.format_string!()
    |> then(&File.write!(output_tweet_items_path, &1, [:binary, :write]))

    Logger.info("=> write html pages under root dir: #{output_html_root_dir}")
    Logger.info("=> => mkdir: #{output_html_root_dir}")
    File.mkdir_p!(output_html_root_dir)

    for %{html: html, html_filename: filename} <- webpages do
      path = Path.join(output_html_root_dir, filename)
      Logger.info("=> => write html: #{path}")
      File.write!(path, html, [:binary, :write])
    end

    Logger.info("Done")
  end
end
