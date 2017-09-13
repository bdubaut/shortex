defmodule ShortyWeb.ErrorViewTest do
  use ShortyWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "render 400.json" do
    assert render(ShortyWeb.ErrorView, "400.json", []) ==
      %{errors: "url is not present."}
  end

  test "renders 404.json" do
    assert render(ShortyWeb.ErrorView, "404.json", []) ==
           %{errors: "The shortcode cannot be found in the system"}
  end


  test "render 409.json" do
    assert render(ShortyWeb.ErrorView, "409.json", []) ==
           %{errors: "The the desired shortcode is already in use. Shortcodes are case-sensitive."}
  end

  test "render 422.json" do
    assert render(ShortyWeb.ErrorView, "422.json", []) ==
           %{errors: "The shortcode fails to meet the following regexp: `^[0-9a-zA-Z_]{4,}$`."}
  end

  test "render 500.json" do
    assert render(ShortyWeb.ErrorView, "500.json", []) ==
      %{errors: "Internal server error"}
    end

  test "render any other" do
    assert render(ShortyWeb.ErrorView, "505.json", []) ==
           %{errors: "Internal server error"}
  end
end
