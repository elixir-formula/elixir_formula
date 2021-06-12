defmodule ElixirFormula.Publications do
  @moduledoc """
  The Publications context.
  """

  alias ElixirFormula.Publications.Schemas.Publication

  alias ElixirFormula.Publications.Services.{
    CreatePublication,
    GetPublication,
    GetPublicationsList,
    PublishPublication,
    UpdatePublication
  }

  @doc """
  Returns list of publications with optional filtered params.

  ## Parameters:

  * `params` - Map of parameters for creating
    * `status` - published status

  ## Examples

      iex> list_publications(%{})
      %Scrivener.Page{entries: [%Publication{}, ...], page_number: 1, page_size: 10, total_entries: 2, total_pages: 1}

      iex> list_publications(%{status: :pending, page: 2})
      %Scrivener.Page{entries: [%Publication{status: "pernding"}, ...], page_number: 2, page_size: 10, total_entries: 15, total_pages: 2}
  """
  @spec list_publications(map()) :: Scrivener.Page.t()
  defdelegate list_publications(params), to: GetPublicationsList, as: :call

  @doc """
  Returns publications by searching field.

  ## Examples

      iex> get_publication(:id, 1)
      {:ok, %Publication{}}

      iex> get_publication(:id, 0)
      {:error, :publication_not_found}
  """
  @spec get_publication(atom(), integer() | binary()) :: {:ok, Publication.t()} | {:error, :publication_not_found}
  defdelegate get_publication(field, value), to: GetPublication, as: :call

  @doc """
  Creates a publication

  ## Parameters

  * `params` - Map of parameters for creating
      * `title` - publication title
      * `url` - publication url
      * `tags` - list of tags
      * `author_name` - publication author name
      * `source` - name of scraping website

  ## Examples

      iex> create_publication(%{
        title: "Elixir is awesome",
        url: "https://dev.to/elixir-is-awesome",
        tags: ["elixir", "development", "language"],
        author_name: "john doe",
        source: "dev.to"
      })
      {:ok, %Publication{}}

      iex> create_publication(%{
        title: "existing title",
        url: "https://dev.to/existing-title",
        tags: ["elixir"],
        author_name: "existing author",
        source: "dev.to"
      })
      {:ok, nil}

      iex> create_publication(%{})
      {:error, %Ecto.Changeset{}}
  """
  @spec create_publication(map()) :: {:ok, Publication.t()} | {:ok, nil} | {:error, Ecto.Changeset.t()}
  defdelegate create_publication(params), to: CreatePublication, as: :call

  @doc """
  Updates a publication

  ## Examples

      iex> update_publication(publication, %{status: :published})
      {:ok, %Publication{}}

      iex> update_publication(publication, %{title: ""})
      {:error, %Ecto.Changeset{}}
  """
  @spec update_publication(Publication.t(), map()) :: {:ok, Publication.t()} | {:error, Ecto.Changeset.t()}
  defdelegate update_publication(publication, params), to: UpdatePublication, as: :call

  @doc """
  Publish a publication


  """
  @spec publish_publication(Publication.t()) :: {:ok, Nadia.Model.Message.t()}
  defdelegate publish_publication(publication), to: PublishPublication, as: :call
end
