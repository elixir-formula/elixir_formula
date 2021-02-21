defmodule ElixirFormula.Publications.List do
  @moduledoc false

  import Ecto.Query

  alias ElixirFormula.{Publication, Repo}

  @doc """
  Returns list of publications with optional filtered params.
  Available filters:
    - by status

  ## Examples

      iex> List.call(%{})
      [%Publication{}, ]

      iex> List.call(%{"status" => "pending"})
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
