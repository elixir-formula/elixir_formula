defmodule ElixirFormula.Publications.Services.UpdatePublication do
  @moduledoc false
  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Repo

  @doc """
  Updates a publication.

  ## Examples

      iex> UpdatePublication.call(publication, %{status: :rejected})
      {:ok, %Publication{}}

      iex> UpdatePublication.call(publication, %{title: ""})
      {:error, %Ecto.Changeset{}}
  """
  @spec call(Publication.t(), map()) :: {:ok, Publication.t()} | {:error, Ecto.Changeset.t()}
  def call(publication, params) do
    publication
    |> Publication.changeset(params)
    |> Repo.update()
  end
end
