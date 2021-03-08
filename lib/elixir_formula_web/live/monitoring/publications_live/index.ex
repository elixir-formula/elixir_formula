defmodule ElixirFormulaWeb.Monitoring.PublicationsLive.Index do
  use ElixirFormulaWeb, :live_view

  alias ElixirFormula.Publications
  alias ElixirFormula.Publications.Schemas.Publication

  def mount(_params, _session, socket) do
    socket = assign(socket, publications: Publications.list_publications(%{"status" => "pending"}))
    {:ok, socket, temporary_assigns: [publications: []]}
  end

  # Helpers

  defp publication_tags(%Publication{tags: tags}) do
    tags
    |> Enum.map(&("##{&1}"))
    |> Enum.join(" ")
  end

  defp published_at(%Publication{inserted_at: inserted_at}) do
    Timex.format!(inserted_at, "%b %d, %Y", :strftime)
  end
end
