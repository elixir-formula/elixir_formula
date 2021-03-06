import Config

config :elixir_formula, ElixirFormula.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: 2

config :elixir_formula, ElixirFormulaWeb.Endpoint,
  http: [:inet6, port: 4000],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  url: [scheme: "https", host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 443],
  check_origin: ["https://" <> System.get_env("APP_NAME") <> ".gigalixirapp.com", "//localhost"],
  server: true,
  live_view: [signing_salt: System.get_env("LIVEVIEW_SALT")]

config :nadia,
  token: System.get_env("TELEGRAM_BOT_TOKEN"),
  channel_id: System.get_env("TELEGRAM_CHANNEL_ID")

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")
