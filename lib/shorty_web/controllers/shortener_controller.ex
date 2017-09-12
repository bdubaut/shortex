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
      url = qualify_url(link.url)
      conn
      |> put_status(302)
      |> redirect(external: url)
    end
  end

  def stats(conn, %{"shortcode" => shortcode}) do
    with {:ok, link} <- Links.stats(shortcode) do
      conn
      |> put_status(200)
      |> render("stats.json", link: link)
    end
  end

  defp qualify_url(url) do
    if Regex.match?(~r/https{0,}:\/\//, url) do
      url
    else
      "https://#{url}"
    end
  end
end
