defmodule ShortyWeb.ShortenerViewTest do
  use ShortyWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  alias Shorty.Links

  test "renders create.json", context do
    link = %Links.Link{
      url: "example.com",
      shortcode: "shortcode",
      redirect_count: 1,
      start_date: DateTime.utc_now |> DateTime.to_iso8601,
      last_seen_date: DateTime.utc_now |> DateTime.to_iso8601
    }

    assert render(ShortyWeb.ShortenerView, "create.json", %{link: link}) ==
           %{shortcode: link.shortcode}
  end

  test "renders stats.json when redirect_count = 0" do
    link = %Links.Link{
      url: "example.com",
      shortcode: "shortcode",
      redirect_count: 0,
      start_date: DateTime.utc_now |> DateTime.to_iso8601,
      last_seen_date: DateTime.utc_now |> DateTime.to_iso8601
    }

    assert render(ShortyWeb.ShortenerView, "stats.json", %{link: link}) ==
           %{
             redirectCount: 0,
             startDate: link.start_date
           }
  end

  test "renders stats.json when redirect_count > 0" do
    link = %Links.Link{
      url: "example.com",
      shortcode: "shortcode",
      redirect_count: 1,
      start_date: DateTime.utc_now |> DateTime.to_iso8601,
      last_seen_date: DateTime.utc_now |> DateTime.to_iso8601
    }

    assert render(ShortyWeb.ShortenerView, "stats.json", %{link: link}) ==
           %{
             redirectCount: 1,
             startDate: link.start_date,
             lastSeenDate: link.last_seen_date
           }
  end
end
