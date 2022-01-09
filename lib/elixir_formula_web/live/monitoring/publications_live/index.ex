defmodule ElixirFormulaWeb.Monitoring.PublicationsLive.Index do
  @moduledoc """
  Admin publications page.
  """
  use ElixirFormulaWeb, :live_view

  alias ElixirFormula.Publications
  alias ElixirFormula.Publications.Schemas.Publication

  def mount(_params, session, socket) do
    socket =
      socket
      |> assign_user(session)
      |> assign_publications()

    {:ok, socket, temporary_assigns: [publications: []]}
  end

  def handle_event("publish", %{"id" => id}, socket) do
    with {:ok, publication} <- Publications.get_publication(:id, id),
         {:ok, _message} <- Publications.send_publication(publication) do
      {:noreply, assign_publications(socket)}
    end
  end

  def handle_event("reject", %{"id" => id}, socket) do
    with {:ok, publication} <- Publications.get_publication(:id, id),
         {:ok, _publication} <- Publications.update_publication(publication, %{status: :rejected}) do
      {:noreply, assign_publications(socket)}
    end
  end

  # Helpers

  defp assign_publications(socket) do
    %{entries: publications} = Publications.list_publications(%{status: :pending, page: 1})

    assign(socket, publications: publications)
  end

  defp publication_tags(%Publication{tags: tags}) do
    Enum.map_join(tags, " ", &"##{&1}")
  end

  defp published_at(%Publication{inserted_at: inserted_at}) do
    Calendar.strftime(inserted_at, "%b %d, %Y")
  end
end
