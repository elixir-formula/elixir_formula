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
  secret_key_base: "N5pBS/V0Kiyj0uKFjKIczM4VJb9SaHU4feW6s4z6x8KC2wkWPuofkrxCiZfpdouc",
  render_errors: [view: ElixirFormulaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirFormula.PubSub,
  live_view: [signing_salt: "hoEF+wbG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
