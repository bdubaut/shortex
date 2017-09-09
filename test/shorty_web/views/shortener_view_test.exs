defmodule ShortyWeb.ShortenerViewTest do
  use ShortyWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  alias Shorty.Links

  setup context do
    {:ok, link} = Links.create_link("www.example.com", "blah")
    [link: link]
  end

  test "renders create.json", context do
    assert render(ShortyWeb.ShortenerView, "create.json", %{link: context[:link]}) ==
           %{shortcode: context[:link].shortcode}
  end
end
