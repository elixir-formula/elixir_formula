defmodule ElixirFormula.Repo.Migrations.AddDescriptionAndImageUrlToPublications do
  use Ecto.Migration

  def change do
    alter table(:publications) do
      add :description, :text
      add :image_url, :text
    end
  end
end
