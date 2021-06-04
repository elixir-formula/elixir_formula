defmodule ElixirFormula.Monitoring.Services.UpdateScraperStatus do
  @moduledoc false

  alias ElixirFormula.Monitoring.Schemas.ScraperStatus
  alias ElixirFormula.Repo

  @doc """
  Updates a scraper status.

  ## Examples

      iex> UpdateScraperStatus.call(%{status: :active})
      {:ok, %ScraperStatus{}}
  """
  @spec call(ScraperStatus.t(), map()) :: {:ok, ScraperStatus.t()} | {:error, Ecto.Changeset.t()}
  def call(scraper_status, params) do
    scraper_status
    |> ScraperStatus.changeset(params)
    |> Repo.update()
  end
end
