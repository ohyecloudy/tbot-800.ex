defmodule Tbot800Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [ignore_warnings: ".dialyzer_ignore.exs"]
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 1.2", only: [:dev], runtime: false}
    ]
  end
end
