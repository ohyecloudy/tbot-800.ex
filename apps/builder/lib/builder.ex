defmodule Builder do
  require Logger
  alias Builder.DefaultImpl

  @type quotation_list :: [String.t()]
  @type source ::
          %{quotations: quotation_list} | %{origin: String.t(), quotations: quotation_list}
  @type source_list :: [source]
  @type source_loader :: (() -> source_list())
  @type tweet_items_writer :: (iodata -> :ok)
  @type html_root_dir_maker :: (() -> :ok)
  @type html_file_writer :: (String.t(), iodata -> :ok)

  def run() do
    {args, []} =
      OptionParser.parse!(System.argv(),
        strict: [
          source_path: :string,
          twitter_account: :string,
          html_host_base_url: :string,
          ga4_measurement_id: :string,
          output_tweet_items_path: :string,
          output_html_root_dir: :string
        ]
      )

    build(
      source_loader_func(args[:source_path]),
      args[:twitter_account],
      args[:html_host_base_url],
      args[:ga4_measurement_id],
      tweet_items_writer_func(args[:output_tweet_items_path]),
      html_root_dir_maker_func(args[:output_html_root_dir]),
      html_file_writer_func(args[:output_html_root_dir])
    )
  end

  @spec build(
          source_loader,
          String.t(),
          String.t(),
          String.t(),
          tweet_items_writer,
          html_root_dir_maker,
          html_file_writer
        ) :: :ok
  def build(
        source_loader,
        twitter_account,
        html_host_base_url,
        ga4_measurement_id,
        tweet_items_writer,
        html_root_dir_maker,
        html_file_writer
      ) do
    Logger.info("build tweet items & html pages")

    Logger.info("=> call quote source loader")
    source_list = source_loader.()

    Logger.info(
      "=> make tweet items & html pages account: #{twitter_account}, html_host_base_url: #{html_host_base_url}"
    )

    %{tweet_items: tweet_items, webpages: webpages} =
      current_impl().build(source_list, twitter_account, html_host_base_url, ga4_measurement_id)

    Logger.info("=> call tweet items writer")

    tweet_items
    |> Enum.to_list()
    |> inspect(limit: :infinity)
    |> Code.format_string!()
    |> then(&tweet_items_writer.(&1))

    Logger.info("=> write html pages")
    html_root_dir_maker.()

    for %{html_filename: filename, html: html} <- webpages do
      Logger.info("=> call html file writer")
      html_file_writer.(filename, html)
    end

    Logger.info("Done")

    :ok
  end

  defp source_loader_func(source_path) do
    fn ->
      Logger.info("=> => read quote source file #{source_path}")
      {source_list, _} = Code.eval_file(source_path)
      source_list
    end
  end

  defp tweet_items_writer_func(output_tweet_items_path) do
    fn content ->
      Logger.info("=> => write tweet items: #{output_tweet_items_path}")
      File.write!(output_tweet_items_path, content, [:binary, :write])
      :ok
    end
  end

  defp html_root_dir_maker_func(output_html_root_dir) do
    fn ->
      Logger.info("=> => mkdir: #{output_html_root_dir}")
      File.mkdir_p!(output_html_root_dir)
      :ok
    end
  end

  defp html_file_writer_func(output_html_root_dir) do
    fn filename, content ->
      path = Path.join(output_html_root_dir, filename)
      Logger.info("=> => write html: #{path}")
      File.write!(path, content, [:binary, :write])
      :ok
    end
  end

  def current_impl() do
    DefaultImpl
  end
end
