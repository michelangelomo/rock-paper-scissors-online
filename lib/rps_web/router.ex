defmodule RpsWeb.Router do
  use RpsWeb, :router

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

  scope "/", RpsWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/room/new", RoomController, :new
    get "/room/:name", RoomController, :show
  end

  scope "/api", RpsWeb do
    pipe_through :api
  end
end
