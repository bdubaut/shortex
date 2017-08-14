defmodule Shorty.Links do
  @moduledoc """
  Links Module, internal API to interact with shortlinks
  """

  require IEx
  alias Shorty.Links.Link

  def create_link(args) do
    {:ok, _} = Link.start_link(args)
    Link.fetch(args.shortcode)
  end
end
