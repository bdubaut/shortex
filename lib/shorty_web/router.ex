defmodule ShortyWeb.Router do
  use ShortyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShortyWeb do
    pipe_through :api
    post "/shorten", ShortenerController, :create
    get "/:shortcode", ShortenerController, :show
    get "/:shortcode/stats", ShortenerController, :stats
  end
end
