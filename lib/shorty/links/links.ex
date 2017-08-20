defmodule Shorty.Links do
  @moduledoc """
  Links Module, internal API to interact with shortlinks.

  Implements:
  - `find_link/1`
  - `create_link/1`
  """

  @links_registry :links_registry
  alias Shorty.Links.Link
  require(IEx)

  def find_link(shortcode) do
    case Registry.lookup(@links_registry, shortcode) do
      [{_, _}] ->
        shortcode
        |> Link.via_name
        |> GenServer.call(:fetch)
      [] ->
        {:error, :not_found}
    end
  end

  def create_link(args) do
    {:ok, _} = Link.start_link(args)
    find_link(args.shortcode)
  end

  def increment_redirect_count(shortcode) do
    shortcode
    |> Link.via_name
    |> GenServer.cast(:increment_redirect_count)
  end
end
