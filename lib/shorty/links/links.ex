defmodule Shorty.Links do
  @moduledoc """
    Links Module, internal API to interact with shortlinks.
    It implements 3 main functions :
    - create_link/1
    - fetch_link/1
    - stats returns/1
  """

  @links_registry :links_registry
  alias Shorty.Links.Link
  require(IEx)

  @doc """
    Creates a new link. Generates the shortcode if not present. Errors according to the spec.
  """
  def create_link(options \\ []), do: {:ok, true}

  @doc """
    Fetches a link for redirection. increments the redirection count, and returns the link. Returns
    an error according to the spec.
  """
  def fetch_link(shortcode), do: {:ok, true}

  @doc """
    Returns the link without changing it for stats purposes. Returns an error according to the spec.
  """
  def stats(shortcode), do: {:ok, true}
end
