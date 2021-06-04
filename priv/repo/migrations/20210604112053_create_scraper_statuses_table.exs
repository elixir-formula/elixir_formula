defmodule ElixirFormula.Repo.Migrations.CreateScraperStatusesTable do
  use Ecto.Migration

  def change do
    create table(:scraper_statuses) do
      add :status, :string, default: "inactive", null: false
      add :source, :string
      add :jobs_count, :integer, default: 0, null: false

      timestamps()
    end

    create unique_index(:scraper_statuses, [:source])
  end
end
