defmodule ShortyWeb.ShortenerController do
  use ShortyWeb, :controller

  action_fallback FallbackController

  def create(conn, params) do
    {:ok, conn}
  end
end
