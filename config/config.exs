# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_formula,
  ecto_repos: [ElixirFormula.Repo]

# Configures the endpoint
config :elixir_formula, ElixirFormulaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: ElixirFormulaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirFormula.PubSub,
  live_view: [signing_salt: "hoEF+wbG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Ueberauth
config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user:email"]}
  ]

# Configures Nadia
config :nadia,
  token: System.get_env("TELEGRAM_BOT_TOKEN"),
  channel_id: System.get_env("TELEGRAM_CHANNEL_ID")

# Configures Quantum
config :elixir_formula, Scrapers.Scheduler,
  jobs: [
    {"1 * * * *", {Scrapers.CompaniesBlogs.AppSignal, :run, []}},
    {"2 * * * *", {Scrapers.CompaniesBlogs.AppUnite, :run, []}},
    {"3 * * * *", {Scrapers.CompaniesBlogs.Betterdoc, :run, []}},
    {"4 * * * *", {Scrapers.CompaniesBlogs.CarbonFive, :run, []}},
    {"5 * * * *", {Scrapers.CompaniesBlogs.Coletiv, :run, []}},
    {"6 * * * *", {Scrapers.CompaniesBlogs.Curiosum, :run, []}},
    {"7 * * * *", {Scrapers.CompaniesBlogs.Dashbit, :run, []}},
    {"8 * * * *", {Scrapers.CompaniesBlogs.Dockyard, :run, []}},
    {"9 * * * *", {Scrapers.CompaniesBlogs.ErlangSolutions, :run, []}},
    {"10 * * * *", {Scrapers.CompaniesBlogs.FlyPhoenixFiles, :run, []}},
    {"11 * * * *", {Scrapers.CompaniesBlogs.Fly, :run, []}},
    {"12 * * * *", {Scrapers.CompaniesBlogs.Hashrocket, :run, []}},
    {"13 * * * *", {Scrapers.CompaniesBlogs.Serokell, :run, []}},
    {"14 * * * *", {Scrapers.CompaniesBlogs.Smartlogic, :run, []}},
    {"15 * * * *", {Scrapers.CompaniesBlogs.Thoughtbot, :run, []}},
    {"16 * * * *", {Scrapers.PersonalBlogs.Angelika, :run, []}},
    {"17 * * * *", {Scrapers.PersonalBlogs.Bigargone, :run, []}},
    {"18 * * * *", {Scrapers.PersonalBlogs.ElixirLang, :run, []}},
    {"19 * * * *", {Scrapers.PersonalBlogs.Pentacent, :run, []}},
    {"20 * * * *", {Scrapers.PersonalBlogs.PhoenixFramework, :run, []}},
    {"21 * * * *", {Scrapers.PersonalBlogs.Seanmoriarity, :run, []}},
    {"22 * * * *", {Scrapers.PersonalBlogs.Sorentwo, :run, []}},
    {"23 * * * *", {Scrapers.PersonalBlogs.Staknine, :run, []}},
    {"24 * * * *", {Scrapers.PersonalBlogs.TheGreatCodeAdventure, :run, []}},
    {"25 * * * *", {Scrapers.PersonalBlogs.TodayILearned, :run, []}},
    {"26 * * * *", {Scrapers.Podcasts.Changelog, :run, []}},
    {"27 * * * *", {Scrapers.Podcasts.ElixirMix, :run, []}},
    {"28 * * * *", {Scrapers.Podcasts.ElixirWizards, :run, []}},
    {"29 * * * *", {Scrapers.Podcasts.ThinkingElixir, :run, []}},
    {"30 * * * *", {Scrapers.PublishingPlatforms.DevTo, :run, []}}
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
