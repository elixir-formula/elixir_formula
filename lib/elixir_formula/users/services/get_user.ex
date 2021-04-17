defmodule ElixirFormula.Users.Services.GetUser do
  @moduledoc false
  alias ElixirFormula.Users.Schemas.User
  alias ElixirFormula.Repo

  @doc """
  Returns user by searching field.

  ## Examples

      iex> GetUser.call(:id, 1)
      {:ok, %User{}}

      iex> GetUser.call(:id, 0)
      {:error, :user_not_found}
  """

  @spec call(atom(), integer() | binary()) :: {:ok, %User{}} | {:error, :user_not_found}
  def call(field, value)

  def call(:id, id) do
    case Repo.get_by(User, id: id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :user_not_found}
    end
  end

  def call(:email, email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      _ -> {:error, :user_not_found}
    end
  end
end
