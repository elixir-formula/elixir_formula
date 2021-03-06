defmodule ElixirFormula.Users.Schemas.UserTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.Users.Schemas.User

  setup do
    base_params = %{
      name: "Lady Gaga",
      nickname: "ladyGaga",
      image: "https://i.imgur.com/nnbRwDs.jpeg",
      email: "lady_gaga@gmail.com"
    }

    [base_params: base_params]
  end

  describe "changeset/2" do
    test "returns valid changeset", %{base_params: base_params} do
      changeset = User.changeset(%User{}, base_params)

      assert errors_on(changeset) == %{}
    end

    test "returns invalid chaangeset, when name isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{name: nil})
      changeset = User.changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when nickname isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{nickname: nil})
      changeset = User.changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{nickname: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when image isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{image: nil})
      changeset = User.changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{image: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when email isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{email: nil})
      changeset = User.changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{email: ["can't be blank"]}
    end
  end
end
