defmodule ElixirFormula.Users.Schemas.UserTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.Users.Schemas.User

  setup do
    base_params = %{
      name: "Lady Gaga",
      nickname: "ladyGaga",
      avatar_url: "https://i.imgur.com/nnbRwDs.jpeg"
    }

    [base_params: base_params]
  end

  describe "create_changeset/2" do
    test "returns valid changeset", %{base_params: base_params} do
      changeset = User.create_changeset(%User{}, base_params)

      assert errors_on(changeset) == %{}
    end

    test "returns invalid chaangeset, when name isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{name: nil})
      changeset = User.create_changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when nickname isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{nickname: nil})
      changeset = User.create_changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{nickname: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when avatar_url isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{avatar_url: nil})
      changeset = User.create_changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{avatar_url: ["can't be blank"]}
    end
  end
end
