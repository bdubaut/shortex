defmodule Shorty.LinksTest do
  use ExUnit.Case, async: true

  alias Shorty.Links

  @valid_args %{url: "http://example.com", shortcode: "querty"}

  describe "create_link/1" do
    test "it creates a new link" do
      link = Links.create_link(@valid_args)
      assert(link.url == @valid_args.url)
    end
  end

end
