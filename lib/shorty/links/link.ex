defmodule Shorty.Links.Link do
  @moduledoc """
    Base Link GenServer
  """
  use GenServer
  alias __MODULE__

  defstruct [
    url: nil,
    shortcode: nil,
    redirect_count: 0,
    start_date: DateTime.utc_now |> DateTime.to_iso8601,
    last_seen_date: nil
  ]

  @registry :links_registry

  def via_name(shortcode), do: {:via, Registry, {@registry, shortcode}}

  # Client
  def start_link(url, shortcode) do
    GenServer.start_link(
      __MODULE__,
      %{url: url, shortcode: shortcode},
      name: via_name(shortcode))
  end

  # Server callbacks
  def init(link_args) do
    {:ok, struct(Link, link_args)}
  end

  def handle_call(:lookup, _, state) do
    {:reply, state, state}
  end

  # Private

  # # Callbacks
  #
  # def handle_call(:fetch, _, state) do
  #   {:reply, state, state}
  # end
  #
  # def handle_cast(:increment_redirect_count, state) do
  #   {:noreply, %{state | redirect_count: state.redirect_count + 1}}
  # end
end
