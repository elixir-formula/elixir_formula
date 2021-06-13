defmodule ElixirFormula.Repo.Migrations.AddDescriptionAndImageUrlToPublications do
  use Ecto.Migration

  def change do
    alter table(:publications) do
      add :description, :string
      add :image_url, :string
    end
  end
end
