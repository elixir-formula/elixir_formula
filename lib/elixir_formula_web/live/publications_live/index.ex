defmodule ElixirFormulaWeb.PublicationsLive.Index do
  @moduledoc """
  Main page live view module.
  """
  use ElixirFormulaWeb, :live_view

  alias ElixirFormula.Publications
  alias ElixirFormula.Publications.Schemas.Publication

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [publications: []]}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")

    %{entries: publications, total_pages: total_pages} =
      Publications.list_publications(%{status: :published, page: page})

    socket =
      assign(socket,
        current_page: page,
        total_pages: total_pages,
        publications: publications
      )

    {:noreply, socket}
  end

  # Helpers

  defp publication_tags(%Publication{tags: tags}) do
    tags
    |> Enum.map(&"##{&1}")
    |> Enum.join(" ")
  end

  defp published_at(%Publication{inserted_at: inserted_at}) do
    Timex.format!(inserted_at, "%b %d, %Y", :strftime)
  end
end
