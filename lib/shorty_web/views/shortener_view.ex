defmodule ShortyWeb.ShortenerView do
  use ShortyWeb, :view

  def render("create.json", %{link: link}) do
    %{shortcode: link.shortcode}
  end
end
