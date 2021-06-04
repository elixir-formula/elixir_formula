defmodule ElixirFormula.Monitoring do
  @moduledoc """
  The Monitoring context.
  """

  alias ElixirFormula.Monitoring.Schemas.ScraperStatus

  alias ElixirFormula.Monitoring.Services.{
    GetScraperStatus,
    GetScraperStatusesList,
    UpdateScraperStatus
  }

  @doc """
  Returns list of scraper statuses.

  ## Examples

      iex> list_scraper_statuses()
      [%ScraperStatus{}, ...]
  """
  @spec list_scraper_statuses() :: [ScraperStatus.t(), ...]
  defdelegate list_scraper_statuses(), to: GetScraperStatusesList, as: :call

  @doc """
  Returns scraper status by searching field.

  ## Examples

      iex> get_scraper_status(:id, 1)
      {:ok, %ScraperStatus{}}

      iex> get_scraper_status(:id, 0)
      {:error, :scraper_status_not_found}
  """
  @spec get_scraper_status(atom(), integer() | binary()) :: {:ok, ScraperStatus.t()} | {:error, :scraper_status_not_found}
  defdelegate get_scraper_status(field, value), to: GetScraperStatus, as: :call

  @doc """
  Updates a scraper status.

  ## Examples

      iex> update_scraper_status(scraper_status, %{status: :active})
      {:ok, %ScraperStatus{}}

      iex> update_scraper_status("dev.to", :invalid)
      {:error, %Ecto.Changeset{}}
  """
  @spec update_scraper_status(ScraperStatus.t(), map()) :: {:ok, ScraperStatus.t()} | {:error, Ecto.Changeset.t()}
  defdelegate update_scraper_status(scraper_status, params), to: UpdateScraperStatus, as: :call
end
