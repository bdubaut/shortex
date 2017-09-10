defmodule ShortyWeb.ShortenerControllerTest do
  use ShortyWeb.ConnCase

  alias Shorty.Links
  alias Shorty.Links.Link

  @valid_attrs %{}
  @invalid_attrs %{}
  @conflict_attrs %{}
  @bad_regex_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe ".create/2" do
    @tag :skip
    test "renders shortcode data when the data is valid" do
      response = build_conn
      |> post(shortener_path(build_conn, :create), url: @valid_attrs.url)
      |> json_response(201)

      assert {:ok, link} = link = GenServer.call(Link.via_name(@valid_attrs.shortcode), :lookup)
      assert response["shortcode"] == link.shortcode
    end
    @tag :skip
    test "returns a 400 when the url is missing" do
      response = build_conn
      |> post(shortener_path(build_conn, :create), url: @invalid_attrs.url)
      |> json_response(400)

      assert response["errors"] == "the url is missing."
    end
    @tag :skip
    test "returns a 409 if the shortcode is already in use" do
      response = build_conn
      |> post(shortener_path(build_conn, :create), url: @invalid_attrs.url)
      |> json_response(409)

      assert response["errors"] == "this shortcode is already in use."
    end
    @tag :skip
    test "returns a 422 if the shortcode does not match `^[0-9a-zA-Z_]{4,}$`" do
      conn = post conn, shortener_path(conn, :create), user: @bad_regex_attrs
      response = build_conn
      |> post(shortener_path(build_conn, :create), url: @invalid_attrs.url)
      |> json_response(422)

      assert response["errors"] == "the shortcode does not match the regex."
    end
  end
end
