defmodule ElixirFormula.Users.Services.CreateUserTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.Users.Schemas.User
  alias ElixirFormula.Users.Services.CreateUser

  setup do
    user = insert(:user, email: "hello@gmail.com")

    base_params = %{
      name: "Lady Gaga",
      nickname: "ladyGaga",
      email: "lady_gaga@gmail.com",
      image: "https://i.imgur.com/nnbRwDs.jpeg"
    }

    [base_params: base_params, user: user]
  end

  describe "when user doesn't exist" do
    test "returns {:ok, %User{}}", %{base_params: base_params, user: user} do
      assert {:ok, %User{} = new_user} = CreateUser.call(base_params)
      assert new_user.id != user.id
    end
  end

  describe "when params is invalid" do
    test "returns {:error, %Ecto.Changeset{}}", %{base_params: base_params} do
      base_params = Map.merge(base_params, %{email: ""})
      assert {:error, _changeset} = CreateUser.call(base_params)
    end
  end

  describe "when user already exists" do
    test "returns {:ok, nil}", %{base_params: base_params, user: %User{id: user_id}} do
      base_params = Map.merge(base_params, %{email: "hello@gmail.com"})
      assert {:ok, %User{id: ^user_id}} = CreateUser.call(base_params)
    end
  end
end
