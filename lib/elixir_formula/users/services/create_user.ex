defmodule ElixirFormula.Users.Services.CreateUser do
  @moduledoc false

  alias ElixirFormula.Users.Services.GetUser
  alias ElixirFormula.Users.Schemas.User
  alias ElixirFormula.Repo

  @doc """
  Creates user only when the same user doesn't exists.
  `:email` the main marker for checking a unique user.

  ## Parameters

  * `user_params` - Map of parameters for creating
      * `name` - User name
      * `nickname` - User nickname
      * `email` - User email
      * `image` - User avatar link
      * `location` - City with region

  ## Examples

      iex> CreateUser.call(%{
        name: "Jonh Doe",
        nickname: "john_doe_11",
        image: "https://i.imgur.com/nnbRwDs.jpeg"
      })
      {:ok, %User{}}

      iex> CreateUser.call(%{
        name: "existing user",
        nickname: "john_doe_11",
        image: "https://i.imgur.com/nnbRwDs.jpeg"
      })
      {:ok, %User{}}

      iex> CreateUser.call(%{})
      {:error, %Ecto.Changeset{}}
  """
  @spec call(map()) :: {:ok, User.t()} | {:error, %Ecto.Changeset{}}
  def call(%{email: email} = params) do
    case GetUser.call(:email, email) do
      {:ok, %User{} = user} -> {:ok, user}
      {:error, :user_not_found} -> create_user(params)
    end
  end

  defp create_user(params) do
    %User{}
    |> User.create_changeset(params)
    |> Repo.insert()
  end
end
