defmodule ElixirFormula.Monitoring.Schemas.ScraperStatus do
  @moduledoc """
  Schema for scraper_statuses table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @statuses [:active, :inactive]

  schema "scraper_statuses" do
    field :status, Ecto.Enum, values: @statuses, default: :inactive, null: false
    field :source, :string
    field :jobs_count, :integer, default: 0, null: false

    timestamps(type: :utc_datetime)
  end

  def changeset(scraper_status, attrs \\ %{}) do
    scraper_status
    |> cast(attrs, [:status, :source, :jobs_count])
  end
end
