defmodule Scrapers.Supervisor do
  @moduledoc false
  use Supervisor

  alias Scrapers.CompaniesBlogs
  alias Scrapers.PersonalBlogs
  alias Scrapers.PublishingPlatforms

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      CompaniesBlogs.AppSignal,
      CompaniesBlogs.CarbonFive,
      CompaniesBlogs.Curiosum,
      CompaniesBlogs.Dashbit,
      CompaniesBlogs.Dockyard,
      CompaniesBlogs.ErlangSolutions,
      CompaniesBlogs.Hashrocket,
      CompaniesBlogs.Thoughtbot,
      PersonalBlogs.ElixirLang,
      PublishingPlatforms.DevTo
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
