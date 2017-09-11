defmodule ShortyWeb.ShortenerController do
  use ShortyWeb, :controller

  alias Shorty.Links

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, link} <- Links.create_link(params["url"], params["shortcode"]) do
      conn
      |> put_status(201)
      |> render("create.json", link: link)
    end
  end
end
