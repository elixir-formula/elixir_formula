defmodule ElixirFormula.Monitoring.Services.GetScraperStatus do
  @moduledoc false

  alias ElixirFormula.Monitoring.Schemas.ScraperStatus
  alias ElixirFormula.Repo

  @doc """
  Returns scraper_status by searching field.

  ## Examples

      iex> GetScraperStatus.call(:source, "dev.to")
      {:ok, %ScraperStatus{}}

      iex> GetScraperStatus.call(:source, "unknown")
      {:error, :scraper_status_not_found}
  """
  @spec call(atom(), integer() | binary()) :: {:ok, ScraperStatus.t()} | {:error, :scraper_status_not_found}
  def call(field, value)

  def call(:source, source) do
    case Repo.get_by(ScraperStatus, source: source) do
      %ScraperStatus{} = scraper_status -> {:ok, scraper_status}
      nil -> {:error, :scraper_status_not_found}
    end
  end
end
