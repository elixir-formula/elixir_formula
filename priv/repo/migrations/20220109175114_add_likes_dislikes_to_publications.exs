defmodule ElixirFormula.Repo.Migrations.AddLikesDislikesToPublications do
  use Ecto.Migration

  def change do
    alter table(:publications) do
      add :like_usernames, {:array, :string}, default: []
      add :dislike_usernames, {:array, :string}, default: []
    end
  end
end
