defmodule ElixirFormulaWeb.Plugs.GetCurrentUser do
  @moduledoc false
  @behaviour Plug
  import Plug.Conn

  alias ElixirFormula.Users

  def init(opts), do: opts

  def call(conn, _) do
    conn = assign(conn, :current_user, nil)

    case get_session(conn, :user_id) do
      nil -> conn
      id -> assign_current_user(conn, id)
    end
  end

  defp assign_current_user(conn, id) do
    case Users.get_user(:id, id) do
      {:ok, user} -> assign(conn, :current_user, user)
      _ -> conn
    end
  end
end
