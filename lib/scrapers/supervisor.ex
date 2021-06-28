defmodule Scrapers.Supervisor do
  @moduledoc false
  use Supervisor

  alias Scrapers.CompaniesBlogs
  alias Scrapers.PersonalBlogs
  alias Scrapers.Podcasts
  alias Scrapers.PublishingPlatforms

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      CompaniesBlogs.AppSignal,
      CompaniesBlogs.CarbonFive,
      CompaniesBlogs.Coletiv,
      CompaniesBlogs.Curiosum,
      CompaniesBlogs.Dashbit,
      CompaniesBlogs.Dockyard,
      CompaniesBlogs.ErlangSolutions,
      CompaniesBlogs.Fly,
      CompaniesBlogs.Hashrocket,
      CompaniesBlogs.Smartlogic,
      CompaniesBlogs.Thoughtbot,
      PersonalBlogs.Bigargone,
      PersonalBlogs.Changelog,
      PersonalBlogs.ElixirLang,
      PersonalBlogs.Pentacent,
      PersonalBlogs.PhoenixFramework,
      PersonalBlogs.Seanmoriarity,
      PersonalBlogs.Sorentwo,
      PersonalBlogs.TheGreatCodeAdventure,
      PersonalBlogs.TodayILearned,
      Podcasts.ElixirMix,
      Podcasts.ElixirWizards,
      Podcasts.ThinkingElixir,
      PublishingPlatforms.DevTo
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
