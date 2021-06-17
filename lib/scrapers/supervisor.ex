defmodule Scrapers.Supervisor do
  @moduledoc false
  use Supervisor

  alias Scrapers.CompaniesBlogs
  alias Scrapers.PublishingPlatforms

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      # CompaniesBlogs.AppSignal,
      CompaniesBlogs.CarbonFive
      # CompaniesBlogs.Curiosum,

      # PublishingPlatforms.DevTo
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
