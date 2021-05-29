defmodule ElixirFormula.Publications.Query do
  @moduledoc """
  Publications query module.
  """

  import Ecto.Query

  alias ElixirFormula.Publications.Schemas.Publication

  @doc """
  Filters publications by specific status.
  """
  @spec by_status(Ecto.Query.t() | Publication.t(), binary()) :: Ecto.Query.t()
  def by_status(query, status) do
    where(query, [p], p.status == ^status)
  end
end
