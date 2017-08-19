defmodule Shorty.Links.Link do
  @moduledoc """
    Base Link GenServer
  """
  use GenServer
  alias __MODULE__

  defstruct [url: nil, shortcode: nil]
  @registry :links_registry

  def via_name(shortcode), do: {:via, Registry, {@registry, shortcode}}

  def start_link(args) do
    GenServer.start_link(Link, args, name: via_name(args.shortcode))
  end

  # Callbacks

  def init(args) do
    link = struct(Link, args)
    {:ok, link}
  end

  def handle_call(:fetch, _, state) do
    {:reply, state, state}
  end
end
