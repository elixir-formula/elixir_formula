defmodule ElixirFormulaWeb.Monitoring.PublicationsLive.Index do
  use ElixirFormulaWeb, :live_view

  alias ElixirFormula.Publications

  def mount(_params, _session, socket) do
    socket = assign(socket, publications: Publications.list_publications(%{"status" => "pending"}))
    {:ok, socket, temporary_assigns: [publications: []]}
  end
end
