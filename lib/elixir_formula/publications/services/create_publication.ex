defmodule ElixirFormula.Publications.Services.CreatePublication do
  @moduledoc false

  import Ecto.Query

  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Repo

  @doc """
  Creates publication only when the same publication doesn't exists.
  Checking markers that publication is unique:
  - title
  - author name

  ## Examples

      iex> CreatePublication.call(%{
        title: "Elixir is awesome",
        url: "https://dev.to/elixir-is-awesome",
        tags: ["elixir", "development", "language"],
        author_name: "john doe",
        source: "dev.to"
      })
      {:ok, %Content{}}

      iex> CreatePublication.call(%{
        title: "existing title",
        url: "https://dev.to/existing-title",
        tags: ["elixir"],
        author_name: "existing author",
        source: "dev.to"
      })
      {:ok, nil}

      iex> CreatePublication.call(%{})
      {:error, %Ecto.Changeset{}}
  """
  @spec call(map()) :: {:ok, Publication.t()} | {:ok, nil} | {:error, Ecto.Changeset.t()}
  def call(%{title: title, author_name: author_name} = params) do
    case publication_exists?(title, author_name) do
      true -> {:ok, nil}
      false -> create_publication(params)
    end
  end

  defp create_publication(params) do
    %Publication{}
    |> Publication.create_changeset(params)
    |> Repo.insert()
  end

  defp publication_exists?(title, author_name) do
    Publication
    |> where([p], p.title == ^title and p.author_name == ^author_name)
    |> Repo.exists?()
  end
end
