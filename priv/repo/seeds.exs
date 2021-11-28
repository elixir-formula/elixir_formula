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

Repo.insert(
  %ScraperStatus{
    source: "appsignal.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "appunite.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "bigardone.dev"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "carbonfive.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "coletiv.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "changelog.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "curiosum.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "dashbit.co"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "dev.to"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "dockyard.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "elixir-lang.org"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "elixir_mix"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "elixir_wizards"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "erlang-solutions.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "fly.io"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "hashrocket.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "pentacent.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "phoenixframework.org"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "seanmoriarity.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "serokell.io"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "smartlogic.io"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "sorentwo.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "thegreatcodeadventure.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "thinkingelixir.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "til.hashrocket.com"
  },
  on_conflict: :nothing
)

Repo.insert(
  %ScraperStatus{
    source: "thoughtbot.com"
  },
  on_conflict: :nothing
)
