defmodule ElixirFormulaWeb.AdminPlug do
  @moduledoc false
  @behaviour Plug
  # import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    # here should be a condition that checks user admin or not (need to implement sessions before)

    conn
  end
end
