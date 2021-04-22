defmodule ElixirFormulaWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, _}) do
    conn
    |> put_flash(:error, "Something went wrong")
    |> redirect(to: "/")
  end
end
