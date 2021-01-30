defmodule ElixirFormula.Repo.Migrations.CreatePublications do
  use Ecto.Migration

  def change do
    create table(:publications) do
      add :title, :string
      add :url, :string
      add :tags, {:array, :string}, default: []
      add :author_name, :string
      add :status, :string, default: "pending", null: false
      add :source, :string

      timestamps()
    end
  end
end
