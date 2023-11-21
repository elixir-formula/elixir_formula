defmodule ElixirFormula.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_formula,
      version: "0.1.0",
      elixir: "~> 1.11.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        ci: :test,
        coveralls: :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ElixirFormula.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/factories"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # phoenix
      {:phoenix, "~> 1.6.2"},
      {:phoenix_ecto, "~> 4.4.0"},
      {:ecto_sql, "~> 3.11.0"},
      {:phoenix_live_view, "~> 0.17.5"},
      {:phoenix_html, "~> 3.2.0"},
      {:phoenix_live_reload, "~> 1.4.0", only: :dev},

      # Dashboard and telemetry
      {:phoenix_live_dashboard, "~> 0.6.1"},
      {:telemetry_metrics, "~> 0.6.1"},
      {:telemetry_poller, "~> 1.0.0"},

      # Internationalization and localization
      {:gettext, "~> 0.11"},

      # JSON parser
      {:jason, "~> 1.0"},

      # HTML parser
      {:floki, "~> 0.34.0"},

      # HTTP client
      {:finch, "~> 0.13.0"},

      # Web server
      {:plug_cowboy, "~> 2.6.0"},

      # Database adapter
      {:postgrex, "~> 0.16.1"},

      # Pagination library
      {:scrivener_ecto, "~> 2.0"},

      # Cron-like job scheduler
      {:quantum, "~> 3.4.0"},

      # Telegram bot API wrapper
      {:nadia, "~> 0.7.0"},

      # Github auth
      {:ueberauth, "~> 0.7.0"},
      {:ueberauth_github, "~> 0.8.1"},

      # Testing tools
      {:ex_machina, "~> 2.7.0", only: :test},
      {:excoveralls, "~> 0.15.0", only: :test},
      {:mock, "~> 0.3.7", only: :test},

      # Static code analysis
      {:credo, "~> 1.6.1", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      ci: ["format --check-formatted", "credo --strict", "test"]
    ]
  end
end
