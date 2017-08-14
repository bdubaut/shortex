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

  describe "find_link/1" do
    setup do
      {:ok, pid} = Shorty.Links.Link.start_link(@valid_args)
      %{sample_link: pid}
    end
    test "When the link is foundreturns the %Link{} struct from its shortcode" do
      link = Links.find_link("querty")
      assert(link.__struct__ == Shorty.Links.Link)
      assert(link.url == "http://example.com")
    end
    test "When the link is not found it returns an error" do
      assert Links.find_link("blob") == {:error, :not_found}
    end
  end
end
