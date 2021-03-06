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

  pipeline :admin do
    plug ElixirFormulaWeb.AdminPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirFormulaWeb do
    pipe_through :browser

  end

  scope "/monitoring", ElixirFormulaWeb.Monitoring do
    pipe_through [:browser, :admin]

    live "/", PublicationsLive.Index, :index
    live_dashboard "/dashboard", metrics: ElixirFormulaWeb.Telemetry
  end
end
