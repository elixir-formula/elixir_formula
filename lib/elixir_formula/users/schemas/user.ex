defmodule ElixirFormula.Users.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :nickname, :string
    field :email, :string
    field :avatar_url, :string
    field :location, :string
    field :is_admin, :boolean, default: false, null: false

    timestamps(type: :utc_datetime)
  end

  def create_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :nickname, :email, :avatar_url, :location, :is_admin])
    |> validate_required([:name, :nickname, :email, :avatar_url])
    |> unique_constraint(:email)
  end
end
