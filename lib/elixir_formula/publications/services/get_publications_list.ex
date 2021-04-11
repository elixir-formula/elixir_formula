defmodule ElixirFormula.Publications.Services.GetPublicationsList do
  @moduledoc false

  import ElixirFormula.Publications.Query, only: [by_status: 2]
  import Ecto.Query

  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Repo

  @doc """
  Returns list of publications with optional filtered params.

  ## Parameters:

  * `params` - Map of parameters for creating
    * `status` - published status
    * `page` - page number

  ## Examples

      iex> GetPublicationsList.call(%{})
      %Scrivener.Page{entries: [%Publication{}, ...], page_number: 1, page_size: 10, total_entries: 2, total_pages: 1}

      iex> GetPublicationsList.call(%{status: :pending, page: 2})
      %Scrivener.Page{entries: [%Publication{status: "pernding"}, ...], page_number: 2, page_size: 10, total_entries: 15, total_pages: 2}
  """
  @spec call(map()) :: [%Publication{}, ...]
  def call(params) do
    Publication
    |> filter_by_status(params)
    |> order_by(desc: :id)
    |> paginate(params)
  end

  defp filter_by_status(query, %{status: nil}), do: query
  defp filter_by_status(query, %{status: status}), do: by_status(query, status)
  defp filter_by_status(query, _), do: query

  defp paginate(query, %{page: nil}), do: Repo.paginate(query)
  defp paginate(query, %{page: page}), do: Repo.paginate(query, page: page)
  defp paginate(query, _), do: Repo.paginate(query)
end
