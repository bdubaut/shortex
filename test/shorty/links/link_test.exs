defmodule Shorty.Links.LinkTest do
  use ExUnit.Case, async: true
  require IEx

  alias Shorty.Links.Link

  describe "fetch/1" do
    setup do
      {:ok, pid} = Shorty.Links.Link.start_link(%{url: "http://example.com", shortcode: "qwerty"})
      %{sample_link: pid}
    end
    test "returns the %Link{} struct from its shortcode" do
      link = Link.fetch("qwerty")
      assert(link.__struct__ == Shorty.Links.Link)
      assert(link.url == "http://example.com")
    end
  end
end
