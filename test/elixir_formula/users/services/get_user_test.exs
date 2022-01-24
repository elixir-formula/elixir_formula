defmodule ElixirFormula.Users.Services.GetUserTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.Users.Services.GetUser

  describe "when searching by id" do
    test "returns {:ok, %User{}} when user exists" do
      user = insert(:user)

      assert {:ok, new_user} = GetUser.call(:id, user.id)
      assert new_user.id == user.id
    end

    test "returns error when user doesn't exist" do
      assert {:error, :user_not_found} = GetUser.call(:id, 0)
    end
  end

  # describe "when searching by email" do
  #   test "returns {:ok, %User{}} when user exists" do
  #     user = insert(:user)
  #
  #     assert {:ok, new_user} = GetUser.call(:email, user.email)
  #     assert new_user.id == user.id
  #   end
  #
  #   test "returns error when user doesn't exist" do
  #     assert {:error, :user_not_found} = GetUser.call(:email, "fake_email@gmail.com")
  #   end
  # end
end
