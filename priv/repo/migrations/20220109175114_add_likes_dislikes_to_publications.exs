defmodule ElixirFormula.Repo.Migrations.AddLikesDislikesToPublications do
  use Ecto.Migration

  def change do
    alter table(:publications) do
      add :like_users, {:array, :integer}, default: []
      add :dislike_users, {:array, :integer}, default: []
    end
  end
end
