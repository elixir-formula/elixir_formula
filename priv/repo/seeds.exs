# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirFormula.Repo.insert!(%ElixirFormula.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ElixirFormula.Repo
alias ElixirFormula.Monitoring.Schemas.ScraperStatus

Repo.insert(%ScraperStatus{
  source: "dev.to"
}, on_conflict: :nothing)

Repo.insert(%ScraperStatus{
  source: "curiosum"
}, on_conflict: :nothing)
