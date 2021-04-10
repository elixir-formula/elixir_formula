defmodule ElixirFormula.Publications do
  @moduledoc """
  The Publications context.
  """

  alias ElixirFormula.Publications.Schemas.Publication

  alias ElixirFormula.Publications.Services.{
    GetPublicationsList,
    CreatePublication
  }

  @doc """
  Returns list of publications with optional filtered params.

  ## Parameters:

  * `params` - Map of parameters for creating
    * `status` - published status

  ## Examples

      iex> list_publications(%{})
      %Scrivener.Page[%Publication{}, ]

      iex> list_publications(%{status: "pending", page: 2})
      %Scrivener.Page{entries: [%Publication{}, ...], page_number: 2, page_size: 10, total_entries: 2, total_pages: 1}
  """
  @spec list_publications(map()) :: [%Publication{}, ...]
  defdelegate list_publications(params), to: GetPublicationsList, as: :call

  @doc """
  Creates a publication

  ## Examples

      iex> create_publication(%{
        "title" => "Elixir is awesome",
        "url" => "https://dev.to/elixir-is-awesome",
        "tags" => ["elixir", "development", "language"],
        "author_name" => "john doe",
        "source" => "dev.to"
      })
      {:ok, %Content{}}

      iex> create_publication(%{
        "title" => "existing title",
        "url" => "https://dev.to/existing-title",
        "tags" => ["elixir"],
        "author_name" => "existing author",
        "source" => "dev.to"
      })
      {:ok, nil}

      iex> create_publication(%{})
      {:error, %Ecto.Changeset{}}
  """
  @spec create_publication(map()) ::
          {:ok, %Publication{}} | {:ok, nil} | {:error, Ecto.Changeset.t()}
  defdelegate create_publication(params), to: CreatePublication, as: :call
end
