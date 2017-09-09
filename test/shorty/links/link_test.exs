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

  describe "call/2" do
    setup context do
      {:ok, pid} = Link.start_link("www.example.com", "bogus2")
      [link: :sys.get_state(pid)]
    end

    # @tag :skip
    test "call(server, :lookup) when the Link exists returns the current state of the Link", context do
      assert GenServer.call(Link.via_name(context[:link].shortcode), :lookup) == context[:link]
    end
  end

  describe "cast/2" do
    setup context do
      {:ok, pid} = Link.start_link("www.example.com", "blah")
      [pid: pid, link: GenServer.call(pid, :lookup)]
    end

    test "cast(server, :increment_redirect_count) and changes the redirection information", context do
      assert(context[:link].redirect_count == 0)
      assert(context[:link].last_seen_date == nil)
      GenServer.cast(context[:pid], :increment_redirect_count)
      link = GenServer.call(context[:pid], :lookup)
      refute(link.last_seen_date == nil)
      assert(link.redirect_count == 1)
    end
  end
end
