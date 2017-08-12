defmodule ShortyWeb.Router do
  use ShortyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShortyWeb do
    pipe_through :api
  end
end
