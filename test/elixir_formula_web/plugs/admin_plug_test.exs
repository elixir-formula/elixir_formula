defmodule ElixirFormulaWeb.Plugs.AdminPlugTest do
  use ElixirFormulaWeb.ConnCase

  alias ElixirFormulaWeb.Plugs.AdminPlug

  describe "when user is admin" do
    test "successfully passed request", %{conn: conn} do
      user = insert(:user, is_admin: true)

      conn =
        conn
        |> assign(:current_user, user)
        |> AdminPlug.call(%{})

      assert nil == conn.resp_body
    end
  end

  describe "when user is not admin" do
    test "request halts", %{conn: conn} do
      user = insert(:user, is_admin: false)

      conn =
        conn
        |> assign(:current_user, user)
        |> AdminPlug.call(%{})

      assert "<html><body>You are being <a href=\"/\">redirected</a>.</body></html>" = html_response(conn, 302)
    end
  end
end
