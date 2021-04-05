defmodule ElixirFormula.Repo do
  use Ecto.Repo,
    otp_app: :elixir_formula,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
