defmodule ElixirFormulaWeb.LiveHelpers do
  import Phoenix.LiveView

  alias ElixirFormula.Users

  def assign_user(%{"user_id" => user_id}, socket) do
    case Users.get_user(:id, user_id) do
      {:ok, user} -> assign(socket, current_user: user)
      {:error, _} -> socket
    end
  end

  def assign_user(_session, socket) do
    socket
  end
end
