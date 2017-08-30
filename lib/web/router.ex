defmodule Web.Router do
  use Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Web do
    pipe_through :browser

    get "/", PageController, :index

    get "/play", PlayController, :show
  end

  scope "/admin", Web.Admin do
    pipe_through :browser

    get "/", DashboardController, :index

    resources "/classes", ClassController, only: [:index, :show, :new, :create, :edit, :update] do
      resources "/skills", SkillController, only: [:new, :create]
    end

    resources "/config", ConfigController, only: [:index]

    resources "/items", ItemController, only: [:index, :show, :edit, :update, :new, :create]

    resources "/rooms", RoomController, only: [:show, :edit, :update]

    resources "/sessions", SessionController, only: [:new, :create]

    resources "/skills", SkillController, only: [:show]

    resources "/users", UserController, only: [:index, :show]

    resources "/zones", ZoneController, only: [:index, :show, :new, :create, :edit, :update] do
      resources "/rooms", RoomController, only: [:new, :create]
    end
  end
end
