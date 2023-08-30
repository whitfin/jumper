defmodule Jumper.MixProject do
  use Mix.Project

  @version "1.0.2"
  @url_docs "http://hexdocs.pm/jumper"
  @url_github "https://github.com/whitfin/jumper"

  def project do
    [
      app: :jumper,
      name: "Jumper",
      description: "Jump consistent hash implementation in Elixir",
      package: %{
        files: [
          "lib",
          "mix.exs",
          "LICENSE"
        ],
        licenses: ["MIT"],
        links: %{
          "Docs" => @url_docs,
          "GitHub" => @url_github
        },
        maintainers: ["Isaac Whitfield"]
      },
      version: @version,
      elixir: "~> 1.2",
      deps: deps(),
      docs: [
        source_ref: "v#{@version}",
        source_url: @url_github
      ],
      test_coverage: [
        tool: ExCoveralls
      ],
      preferred_cli_env: [
        docs: :docs,
        bench: :bench,
        coveralls: :cover,
        "coveralls.html": :cover,
        "coveralls.github": :cover
      ],
      aliases: [
        bench: "run benchmarks/main.exs"
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
      # Testing dependencies
      {:excoveralls, "~> 0.17", optional: true, only: [:cover]},
      # Benchmarking dependencies
      {:benchee, "~> 1.1", optional: true, only: [:bench]},
      {:benchee_html, "~> 1.0", optional: true, only: [:bench]},
      # Documentation dependencies
      {:ex_doc, "~> 0.30", optional: true, only: [:docs]}
    ]
  end
end
