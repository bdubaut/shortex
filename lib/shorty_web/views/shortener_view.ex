defmodule ShortyWeb.ShortenerView do
  use ShortyWeb, :view

  def render("create.json", %{link: link}) do
    %{shortcode: link.shortcode}
  end

  def render("stats.json", %{link: link}) do
    if link.redirect_count > 0 do
      %{
        startDate:      link.start_date,
        lastSeenDate:   link.last_seen_date,
        redirectCount:  link.redirect_count
      }
    else
      %{
        startDate:      link.start_date,
        redirectCount:  link.redirect_count
      }
    end
  end
end
