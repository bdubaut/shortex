defmodule Shorty.Links.Link do
  use GenServer
  alias Shorty.Links.Link

  defstruct [url: nil, shortcode: nil]
  @registry :links_registry

  def via_name(shortcode), do: {:via, Registry, {@registry, shortcode}}

  def start_link(args) do
    GenServer.start_link(Link, args, name: via_name(args.shortcode))
  end

  def fetch(shortcode) do
    GenServer.call(via_name(shortcode), :fetch)
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
