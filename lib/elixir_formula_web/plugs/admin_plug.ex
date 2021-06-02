defmodule ElixirFormulaWeb.Plugs.AdminPlug do
  @moduledoc false

  @behaviour Plug

  alias ElixirFormula.Users.Schemas.User
  alias ElixirFormulaWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(%{assigns: %{current_user: %User{is_admin: true}}} = conn, _) do
    conn
  end

  def call(conn, _) do
    conn
    |> Phoenix.Controller.redirect(to: Routes.publications_index_path(conn, :index))
    |> Plug.Conn.halt()
  end
end
