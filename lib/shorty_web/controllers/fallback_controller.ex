defmodule FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ShortyWeb.ErrorView, :"404")
  end

  def call(conn, {:error, :shortcode_already_in_use}) do
    conn
    |> put_status(:conflict)
    |> render(ShortyWeb.ErrorView, :"409")
  end

  def call(conn, {:error, :regex_not_matched}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ShortyWeb.ErrorView, :"422")
  end

  def call(conn, {:error, :url_not_present}) do
    conn
    |> put_status(:bad_request)
    |> render(ShortyWeb.ErrorView, :"400")
  end
end
