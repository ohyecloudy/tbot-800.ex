defmodule Tbot800.MixProject do
  use Mix.Project

  def project do
    [
      app: :tbot800,
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
      extra_applications: [:logger],
      mod: {Tbot800.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:extwitter, "~> 0.14.0"},
      {:sentry, "~> 8.0"},
      {:jason, "~> 1.1"},
      {:hackney, "~> 1.8"},
      {:mox, "~> 1.0", only: :test}
    ]
  end
end
