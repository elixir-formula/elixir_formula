defmodule ElixirFormulaWeb.LiveHelpers do
  @moduledoc """
  Assign current user into socket.
  """
  import Phoenix.LiveView

  alias ElixirFormula.Users

  def assign_user(socket, %{"user_id" => user_id}) do
    case Users.get_user(:id, user_id) do
      {:ok, user} -> assign(socket, current_user: user)
      {:error, _} -> socket
    end
  end

  def assign_user(socket, _session) do
    socket
  end
end
