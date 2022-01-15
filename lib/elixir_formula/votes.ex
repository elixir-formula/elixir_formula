defmodule ElixirFormula.Votes do
  @moduledoc """
  The Votes context.
  """

  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Votes.Services.Voting

  @doc """
  Like or dislike telegram publication.

  ## Examples

    iex> voting(publication, :like, 426157252, "1830289373843506415")
    {:ok, %User{}}
  """
  @spec voting(publication :: Publication.t(), action :: atom(), user_id :: integer(), callback_id :: binary()) :: :ok
  defdelegate voting(publication, action, user_id, callback_id), to: Voting, as: :call
end
