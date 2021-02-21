defmodule ElixirFormula.Publications do
  @moduledoc """
  The Publications context.
  """

  alias ElixirFormula.{Publication, Publications}

  @doc """
  Returns list of publications.

  ## Examples

    iex> list_publications()
    [%Publication{}, ...]

    iex> list_publications(%{"status" => "published"})
    [%Publication{status: "published"}, ...]
  """
  @spec list_publications(map()) :: [%Publication{}, ...]
  def list_publications(params \\ %{}) do
    Publications.List.call(params)
  end

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
  @spec create_publication(map()) :: {:ok, %Publication{}} | {:ok, nil} | {:error, Ecto.Changeset.t()}
  def create_publication(publication_params) do
    Publications.Create.call(publication_params)
  end
end
