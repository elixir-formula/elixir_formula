defmodule ElixirFormulaWeb.AuthController do
  @moduledoc false

  use ElixirFormulaWeb, :controller

  alias ElixirFormula.Users

  plug Ueberauth

  action_fallback ElixirFormulaWeb.FallbackController

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    with params <- Map.from_struct(auth.info),
         {:ok, user} <- Users.create_user(params) do
      conn
      |> put_session(:user_id, user.id)
      |> configure_session(renew: true)
      |> redirect(to: "/")
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> redirect(to: "/")
  end
end
