defmodule ShortyWeb.ShortenerControllerTest do
  use ShortyWeb.ConnCase, async: true

  alias Shorty.Links

  @full_attrs %{"url" => "example.com", "shortcode" => "my_code1"}
  @bad_rexgex_arg %{"url" => "example.com", "shortcode" => "()!-?)"}


  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe ".create/2" do
    test "renders the shortcode data when the data is valid and shortcode here" do
      response = build_conn()
        |> post(shortener_path(build_conn(), :create), @full_attrs)
        |> json_response(201)

      assert response["shortcode"] == @full_attrs["shortcode"]
    end

    test "renders the shortcode data when there is only a url" do
      response = build_conn()
        |> post(shortener_path(build_conn(), :create), %{"url" => "example.com"})
        |> json_response(201)

      refute response["shortcode"] == nil
      assert response["errors"] == nil
    end

    test "returns a 400 when the url is missing" do
      response = build_conn()
      |> post(shortener_path(build_conn(), :create),  %{"shortcode" => "bad_one"})
      |> json_response(400)

      assert response["errors"] == "url is not present."
    end

    test "returns a 409 if the shortcode is already in use" do
      Links.create_link(@full_attrs["url"], @full_attrs["shortcode"])
      response = build_conn()
      |> post(shortener_path(build_conn(), :create), @full_attrs)
      |> json_response(409)

      assert response["errors"] == "The the desired shortcode is already in use." <>
        " Shortcodes are case-sensitive."
    end

    test "returns a 422 if the shortcode does not match `^[0-9a-zA-Z_]{4,}$`" do
      response = build_conn()
      |> post(shortener_path(build_conn(), :create), @bad_rexgex_arg)
      |> json_response(422)

      assert response["errors"] == "The shortcode fails to meet the following regexp:" <>
        " `^[0-9a-zA-Z_]{4,}$`."
    end
  end
end
