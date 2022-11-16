defmodule ChallengeAppWeb.Router do
  use ChallengeAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ChallengeAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChallengeAppWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/page_a", ChallengeAppWeb do
    pipe_through :browser

    live "/", PageALive.Index, :index
  end

  scope "/page_b", ChallengeAppWeb do
    pipe_through :browser

    live "/", PageBLive.Index, :index
  end

  scope "/page_c", ChallengeAppWeb do
    pipe_through :browser

    live "/", PageCLive.Index, :index
    live "/tab_:tab", PageCLive.Index, :index
  end
end
