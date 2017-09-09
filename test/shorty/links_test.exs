defmodule Shorty.LinksTest do
  use ExUnit.Case, async: true

  alias Shorty.Links

  describe "create_link/2" do
    test "creates a new link with a generated shortcode when a shortcode is not provided" do
      {:ok, link} = Links.create_link("http://www.example.com")

      assert link.url == "http://www.example.com"
      assert link.shortcode != nil
    end

    test "creates a new link when a shortcode is provided" do
      {:ok, link} = Links.create_link("http://www.example.com", "qwerty")

      assert link.url == "http://www.example.com"
      assert link.shortcode == "qwerty"
    end

    test "fails if the provided shortcode is already in use" do
      code = "qwerty"
      Links.create_link("www.blah.com", code)

      assert {:error, :shortcode_already_in_use} == Links.create_link("www.blah.com", code)
    end

    test "fails if the provided shohrtcode does not match the regex" do
      code = ",.1&@()"

      refute Regex.match?(~r/^[0-9a-zA-Z_]{4,}$/, code)
      assert {:error, :regex_not_matched} == Links.create_link("www.blah.com", code)
    end
  end

  describe "fetch_link/1" do
    setup context do
      {:ok, pid} = Links.Link.start_link("www.example.com", "qwerty")
      [link: :sys.get_state(pid), pid: pid]
    end

    test "returns the link", context do
      {:ok, link} = Links.fetch_link(context[:link].shortcode)
      assert(context[:link] == link)
    end

    test "increments the redirect count", context do
      link = GenServer.call(context[:pid], :lookup)
      assert(link.redirect_count == 0)

      Links.fetch_link(context[:link].shortcode)

      link = GenServer.call(context[:pid], :lookup)
      assert(link.redirect_count == 1)
    end

    test "fails if the link is not found" do
      assert({:error, :not_found} == Links.fetch_link("bogus"))
    end
  end
  #
  describe "stats/1" do
    setup context do
      {:ok, pid} = Links.Link.start_link("www.example.com", "qwerty")
      [link: :sys.get_state(pid), pid: pid]
    end

    test "returns the link", context do
      {:ok, link} = Links.stats(context[:link].shortcode)
      assert(context[:link] == link)
    end

    test "fails if the link is not found" do
      assert({:error, :not_found} == Links.stats("bogus"))
    end
  end
end
