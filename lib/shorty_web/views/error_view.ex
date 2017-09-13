defmodule ShortyWeb.ErrorView do
  use ShortyWeb, :view

  def render("400.json", _assigns) do
    %{errors: "url is not present."}
  end

  def render("404.json", _assigns) do
    %{errors: "The shortcode cannot be found in the system"}
  end

  def render("409.json", _assigns) do
    %{errors: "The the desired shortcode is already in use. Shortcodes are case-sensitive."}
  end

  def render("422.json", _assigns) do
    %{errors: "The shortcode fails to meet the following regexp: `^[0-9a-zA-Z_]{4,}$`."}
  end

  def render("500.json", _assigns) do
    %{errors: "Internal server error"}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end
