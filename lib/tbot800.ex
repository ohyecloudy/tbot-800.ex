defmodule Tbot800 do
  require Logger
  alias Tbot800.Builder

  def run() do
    apply(__MODULE__, :build, System.argv())
  end

  def build(source_path, twitter_account, base_url, tweet_items_path, html_root_dir) do
    Logger.info("build tweet items & html pages")

    Logger.info("=> read quote source file #{source_path}")
    {source_list, _} = Code.eval_file(source_path)

    Logger.info(
      "=> make tweet items & html pages account: #{twitter_account}, base_url: #{base_url}"
    )

    %{tweet_items: tweet_items, webpages: webpages} =
      Builder.build(source_list, twitter_account, base_url)

    Logger.info("=> write tweet items: #{tweet_items_path}")

    tweet_items
    |> Enum.to_list()
    |> inspect(limit: :infinity)
    |> Code.format_string!()
    |> then(&File.write!(tweet_items_path, &1, [:binary, :write]))

    Logger.info("=> write html pages under root dir: #{html_root_dir}")
    Logger.info("=> => mkdir: #{html_root_dir}")
    File.mkdir_p!(html_root_dir)

    for %{html: html, html_filename: filename} <- webpages do
      path = Path.join(html_root_dir, filename)
      Logger.info("=> => write html: #{path}")
      File.write!(path, html, [:binary, :write])
    end

    Logger.info("Done")
  end
end
