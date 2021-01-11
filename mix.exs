defmodule Deneb.MixProject do
  use Mix.Project

  @version "0.2.2"
  @vega "5.18.0"
  @vega_lite "4.17.0"
  @vega_embed "6.15.0"

  def vega, do: @vega
  def vega_lite, do: @vega_lite
  def vega_embed, do: @vega_embed

  def project do
    [
      app: :deneb,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Deneb",
      docs: [
        extras: ["README.md"]
      ],
      source_url: "https://github.com/tyrchen/deneb",
      homepage_url: "https://github.com/tyrchen/deneb",
      description: """
      Elixir support for [Vega-lit](https://vega.github.io/vega-lite/), a tool for building interactive graphics.
      """,
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :eex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:elixir_uuid, "~> 1.2"},
      {:typed_struct, "~> 0.2"},

      # dev/test deps
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:credo, "~> 1.5", only: [:dev]}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      maintainers: ["tyr.chen@gmail.com"],
      links: %{
        "GitHub" => "https://github.com/tyrchen/deneb",
        "Docs" => "https://hexdocs.pm/deneb"
      }
    ]
  end
end
