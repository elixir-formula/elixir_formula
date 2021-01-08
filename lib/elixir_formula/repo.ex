defmodule ElixirFormula.Repo do
  use Ecto.Repo,
    otp_app: :elixir_formula,
    adapter: Ecto.Adapters.Postgres
end
