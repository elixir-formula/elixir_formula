defmodule ElixirFormula.Publications.Services.GetPublicationsList do
  @moduledoc false

  import Ecto.Query

  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Repo

  @doc """
  Returns list of publications with optional filtered params.

  ## Parameters:

    * `status` - published status

  ## Examples

      iex> GetPublicationsList.call(%{})
      [%Publication{}, ]

      iex> GetPublicationsList.call(%{"status" => "pending"})
      [%Publication{status: "pending"}]
  """
  @spec call(map()) :: [%Publication{}, ...]
  def call(params)

  def call(%{"status" => status}) do
    Publication
    |> where([p], p.status == ^status)
    |> Repo.all
  end

  def call(_) do
    Repo.all(Publication)
  end
end
