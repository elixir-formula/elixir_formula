defmodule Scrapers.Supervisor do
  use Supervisor

  alias Scrapers.PublishingPlatforms

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      PublishingPlatforms.DevTo
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
