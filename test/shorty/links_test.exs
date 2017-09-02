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

  # describe "fetch_link/1" do
  #   @tag :skip
  #   test "returns the link" do
  #     {:ok, link} = Links.fetch_link(expected_link.shortcode)
  #     assert(expected_link == link)
  #   end
  #
  #   @tag :skip
  #   test "increments the redirect_count for the link" do
  #     {:ok, link} = Links.fetch_link(expected_link.shortcode)
  #     assert(link.redirect_count == expected_link.expected_count + 1)
  #   end
  #
  #   @tag :skip
  #   test "fails if the link is not found" do
  #     assert({:error, "Link not found"} == Links.fetch_link(expected_link.shortcode))
  #   end
  # end
  #
  # describe "stats/1" do
  #   @tag :skip
  #   test "returns the link" do
  #     {:ok, link} = Links.stats(expected_link.shortcode)
  #     assert(expected_link == link)
  #   end
  #
  #   @tag :skip
  #   test "fails if the link is not found" do
  #     assert({:error, "Link not found"} == Links.stats(expected_link.shortcode))
  #   end
  # end
end
