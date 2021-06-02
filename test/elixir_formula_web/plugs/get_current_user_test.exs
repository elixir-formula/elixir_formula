defmodule ElixirFormulaWeb.Plugs.GetCurrentUserTest do
  use ElixirFormulaWeb.ConnCase

  alias ElixirFormula.Users.Schemas.User
  alias ElixirFormulaWeb.Plugs.GetCurrentUser

  describe "when user_id passed" do
    test "successfully passed request", %{conn: conn} do
      user = insert(:user)

      conn =
        conn
        |> init_test_session(user_id: user.id)
        |> GetCurrentUser.call(%{})

      assert %{current_user: %User{}} = conn.assigns
    end
  end

  describe "without user_id" do
    test "successfully passed request", %{conn: conn} do
      conn =
        conn
        |> init_test_session([])
        |> GetCurrentUser.call(%{})

      assert %{current_user: nil} = conn.assigns
    end
  end
end
