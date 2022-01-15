defmodule ElixirFormula.Publications.Services.GetPublication do
  @moduledoc false

  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Repo

  @doc """
  Returns publication by searching field.

  ## Examples

      iex> GetPublication.call(:id, 1)
      {:ok, %Publication{}}

      iex> GetPublication.call(:id, 0)
      {:error, :publication_not_found}
  """
  @spec call(atom(), integer() | binary()) :: {:ok, Publication.t()} | {:error, :publication_not_found}
  def call(field, value)

  def call(:id, id) do
    case Repo.get_by(Publication, id: id) do
      %Publication{} = publication -> {:ok, publication}
      nil -> {:error, :publication_not_found}
    end
  end

  def call(:message_id, message_id) do
    case Repo.get_by(Publication, message_id: message_id) do
      %Publication{} = publication -> {:ok, publication}
      nil -> {:error, :publication_not_found}
    end
  end
end
