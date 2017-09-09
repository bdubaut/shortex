defmodule ShortyWeb.Router do
  use ShortyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShortyWeb do
    pipe_through :api
    post "/shorten", ShortyWeb.ShortenerController, :create
    get "/:shortcode", ShortyWeb.ShortenerController, :show
    get "/:shortcode/stats", ShortyWeb.ShortenerController, :stats
  end
end
