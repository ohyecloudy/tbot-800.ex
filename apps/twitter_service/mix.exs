defmodule TwitterService.MixProject do
  use Mix.Project

  def project do
    [
      app: :twitter_service,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:oauther, "~> 1.3"},
      {:tesla, "~> 1.7"},
      {:jason, "~> 1.4"},
      {:hackney, "~> 1.18"}
    ]
  end
end
