defmodule ElixirFormulaWeb.Monitoring.ScraperStatusesLive.Index do
  @moduledoc """
  Admin scraper statuses page.
  """
  use ElixirFormulaWeb, :live_view

  alias ElixirFormula.Monitoring

  def mount(_params, _session, socket) do
    socket = assign(socket, scraper_statuses: Monitoring.list_scraper_statuses())

    {:ok, socket, temporary_assigns: [scraper_statuses: []]}
  end
end
