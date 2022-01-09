defmodule ElixirFormula.Repo.Migrations.AddMessageIdToPublications do
  use Ecto.Migration

  def change do
    alter table(:publications) do
      add :message_id, :integer
    end
  end
end
