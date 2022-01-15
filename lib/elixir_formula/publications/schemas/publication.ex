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
    field :description, :string
    field :image_url, :string
    field :message_id, :integer
    field :like_users, {:array, :integer}, default: []
    field :dislike_users, {:array, :integer}, default: []

    timestamps(type: :utc_datetime)
  end

  @fields [
    :title,
    :url,
    :tags,
    :author_name,
    :source,
    :status,
    :description,
    :image_url,
    :message_id,
    :like_users,
    :dislike_users,
    :inserted_at
  ]

  def changeset(publication, attrs \\ %{}) do
    publication
    |> cast(attrs, @fields)
    |> validate_required([:title, :url, :author_name, :source])
  end
end
