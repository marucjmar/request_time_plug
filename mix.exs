defmodule RequestTimePlug.MixProject do
  use Mix.Project

  @repo "https://github.com/marucjmar/request_time_plug"

  def project do
    [
      app: :request_time_plug,
      version: "0.2.0",
      elixir: "~> 1.11.2",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      source_url: @repo
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
      {:plug_cowboy, "~> 2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Plug to get constant response time for requests. Simple protection against side channel attacks."
  end

  defp package() do
    [
      licenses: ["MIT"],
      maintainers: ["Marcin Lazar"],
      links: %{"GitHub" => @repo}
    ]
  end
end
