defmodule ElixirFormula.Users do
  @moduledoc """
  The Users context.
  """

  alias ElixirFormula.Users.Schemas.User

  alias ElixirFormula.Users.Services.{
    GetUser,
    CreateUser
  }

  @doc """
  Gets a user by user field.

  ## Parameters

  * `field` - Searching field.
              List of fields: `:id`, `:email`
  * `value` - Searching value

  ## Examples

    iex> get_user(:id, 1)
    {:ok, %User{}}

    iex> get_user(:id, 0)
    {:error, :record_not_found, "User", "id", 0}
  """
  @spec get_user(atom(), integer() | binary()) :: {:ok, User.t()} | {:error, :user_not_found}
  defdelegate get_user(field, value), to: GetUser, as: :call

  @doc """
  Creates a single user.

  ## Parameters

  * `user_params` - Map of parameters for creating
      * `name` - User name
      * `nickname` - User nickname
      * `email` - User email
      * `image` - User avatar link
      * `location` - City with region

  ## Examples

      iex> create_user(%{
        name: "Jonh Doe",
        nickname: "john_doe_11",
        image: "https://i.imgur.com/nnbRwDs.jpeg"
      })
      {:ok, %User{}}

      iex> create_user(%{
        name: "existing user",
        nickname: "john_doe_11",
        image: "https://i.imgur.com/nnbRwDs.jpeg"
      })
      {:ok, %User{}}

      iex> create_user(%{})
      {:error, %Ecto.Changeset{}}
  """
  @spec create_user(map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  defdelegate create_user(params), to: CreateUser, as: :call
end
