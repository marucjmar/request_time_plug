defmodule RequestTimePlug.MixProject do
  use Mix.Project

  @repo "https://github.com/marucjmar/request_time_plug"

  def project do
    [
      app: :request_time_plug,
      version: "0.1.0",
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
      {:plug_cowboy, "~> 2.0"}
    ]
  end

  defp description() do
    "Plug to get constant response time for requests. Simple protection against side channel attacks."
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "request_time_plug",
      # These are the default files included in the package
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["MIT"],
      maintainers: ["Marcin Lazar"],
      links: %{"GitHub" => @repo}
    ]
  end
end
