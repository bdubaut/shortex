defmodule Shorty.LinksTest do
  use ExUnit.Case, async: true

  alias Shorty.Links

  describe "create_link/1" do
    @tag :skip
    test "creates a new link when a shortcode is not provided" do
      {:ok, link} = Links.create_link(url: "http://www.example.com")

      assert link.url == "http://www.example.com"
      assert link.shortcode != nil
      assert link.redirect_count == 0
    end

    @tag :skip
    test "creates a new link when a shortcode is provided" do
      {:ok, link} = Links.create_link(url: "http://www.example.com", shortcode: "qwerty")

      assert link.url == "http://www.example.com"
      assert link.shortcode != "querty"
      assert link.redirect_count == 0
    end

    @tag :skip
    test "fails if the URL is not present" do
      assert {:error, "The URL is not present."} == Links.create_link(shortcode: "qwerty")
    end

    @tag :skip
    test "fails if the provided shortcode is already in use" do
      code = "qwerty"
      assert {:error, "The shortcode #{code} is already in use."} == Links.create_link(url: "www.blah.com", shortcode: code)
    end

    @tag :skip
    test "fails if the provided shohrtcode does not match the regex" do
      code = "qwerty"
      assert {:error, "The shortcode #{code} does not match ^[0-9a-zA-Z_]{4,}$"} == Links.create_link(url: "www.blah.com", shortcode: code)
    end
  end

  describe "fetch_link/1" do
    @tag :skip
    test "returns the link" do
      {:ok, link} = Links.fetch_link(expected_link.shortcode)
      assert(expected_link == link)
    end

    @tag :skip
    test "increments the redirect_count for the link" do
      {:ok, link} = Links.fetch_link(expected_link.shortcode)
      assert(link.redirect_count == expected_link.expected_count + 1)
    end

    @tag :skip
    test "fails if the link is not found" do
      assert({:error, "Link not found"} == Links.fetch_link(expected_link.shortcode))
    end
  end

  describe "stats/1" do
    @tag :skip
    test "returns the link" do
      {:ok, link} = Links.stats(expected_link.shortcode)
      assert(expected_link == link)
    end

    @tag :skip
    test "fails if the link is not found" do
      assert({:error, "Link not found"} == Links.stats(expected_link.shortcode))
    end
  end
end
