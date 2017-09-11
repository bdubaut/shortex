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

  def show(conn, %{"shortcode" => shortcode}) do
    with {:ok, link} <- Links.fetch_link(shortcode) do
      conn
      |> put_status(302)
      |> redirect(external: link.url)
    end
  end
end
