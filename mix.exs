defmodule Gimel.MixProject do
  use Mix.Project

  def project do
    [
      app: :gimel,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug],
      mod: {Gimel.Web, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0.5", only: [:dev, :test], runtime: false},
      {:cowboy, "~> 2.6.3"},
      {:plug, "~> 1.8.0"},
      {:plug_cowboy, "~> 2.0.2"}
    ]
  end

  defp escript do
    [main_module: Gimel.CLI]
  end
end
