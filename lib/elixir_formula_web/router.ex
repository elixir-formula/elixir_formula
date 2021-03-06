defmodule ElixirFormulaWeb.Router do
  use ElixirFormulaWeb, :router

  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ElixirFormulaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :current_user do
    plug ElixirFormulaWeb.Plugs.GetCurrentUser
  end

  pipeline :admin do
    plug ElixirFormulaWeb.Plugs.AdminPlug
  end

  scope "/auth", ElixirFormulaWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/", ElixirFormulaWeb do
    pipe_through [:browser, :current_user]

    live "/", PublicationsLive.Index, :index
  end

  scope "/monitoring", ElixirFormulaWeb.Monitoring do
    pipe_through [:browser, :current_user, :admin]

    live "/", PublicationsLive.Index, :index, as: :monitoring_publications
    live "/statuses", ScraperStatusesLive.Index, :index, as: :monitoring_statuses
    live_dashboard "/dashboard", metrics: ElixirFormulaWeb.Telemetry
  end
end
