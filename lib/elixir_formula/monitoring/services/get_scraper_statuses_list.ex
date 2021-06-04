defmodule ElixirFormula.Monitoring.Services.GetScraperStatusesList do
  @moduledoc false

  alias ElixirFormula.Monitoring.Schemas.ScraperStatus
  alias ElixirFormula.Repo

  @doc """
  Returns list of scraper statuses.

  ## Examples

      iex> GetScraperStatusesList.call()
      [%ScraperStatus{}, ...]
  """
  @spec call :: [ScraperStatus.t(), ...]
  def call do
    Repo.all(ScraperStatus)
  end
end
