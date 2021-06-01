defmodule ElixirFormula.Publications.Schemas.Publication do
  @moduledoc """
  Schema for publications table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @statuses [:pending, :published, :rejected]

  schema "publications" do
    field :title, :string
    field :url, :string
    field :tags, {:array, :string}, default: []
    field :author_name, :string
    field :status, Ecto.Enum, values: @statuses, default: :pending, null: false
    field :source, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(publication, attrs \\ %{}) do
    publication
    |> cast(attrs, [:title, :url, :tags, :author_name, :source, :status])
    |> validate_required([:title, :url, :author_name, :source])
  end
end
