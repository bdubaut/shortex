defmodule Shorty.Links.LinkTest do
  use ExUnit.Case, async: true

  alias Shorty.Links.Link

  describe "start_link/2" do
    test "it creates a `%Shorty.Links.Link{}` struct" do
      {:ok, pid} = Link.start_link("www.example.com", "bogus")
      link = :sys.get_state(pid)

      refute link.start_date == nil
      assert link.shortcode == "bogus"
      assert link.last_seen_date == nil
      assert link.url == "www.example.com"
      assert link.redirect_count == 0
    end
  end
end
