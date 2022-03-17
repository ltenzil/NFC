defmodule FuelCalculator.MixProject do
  use Mix.Project

  def project do
    [
      app: :fuel_calculator,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Fuel Calculator",
      source_url: "https://github.com/ltenzil/NFC",
      homepage_url: "https://ltenzil.github.io/ltenzil/",
      docs: [
        # The main page in the docs
        main: "Fuel Calculator",
        extras: ["README.md"]
      ]
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
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
