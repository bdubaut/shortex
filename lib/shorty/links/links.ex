defmodule Shorty.Links do
  @moduledoc """
    Links Module, internal API to interact with shortlinks.
    It implements 3 main functions :
    - create_link/1
    - fetch_link/1
    - stats/1
  """

  @registry :links_registry
  alias Shorty.Links.Link

  @doc """
  Creates a new link. Generates the shortcode if not present. Errors according
  to the spec.
  """
  def create_link(nil, _), do: {:error, :url_not_present}
  def create_link(url, shortcode \\ nil) do
    case shortcode do
      nil ->
        code = generate_shortcode()
        {:ok, pid} = Link.start_link(url, code)

        {:ok, GenServer.call(pid, :lookup)}
      _ ->
        if validate_shortcode(shortcode) do
          if Registry.lookup(@registry, shortcode) == [] do
            {:ok, pid} = Link.start_link(url, shortcode)

            {:ok, GenServer.call(pid, :lookup)}
          else
            {:error, :shortcode_already_in_use}
          end
        else
          {:error, :regex_not_matched}
        end
    end
  end

  @doc """
    Fetches a link for redirection. increments the redirection count, and returns the link. Returns
    an error according to the spec.
  """
  def fetch_link(shortcode) do
    case Registry.lookup(@registry, shortcode) do
      [] ->
        {:error, :not_found}
      [{_, _}] ->
        link = GenServer.call(Link.via_name(shortcode), :lookup)
        GenServer.cast(Link.via_name(shortcode), :increment_redirect_count)

        {:ok, link}
    end
  end

  @doc """
    Returns the link without changing it for stats purposes. Returns an error according to the spec.
  """
  def stats(shortcode) do
    case Registry.lookup(@registry, shortcode) do
      [] ->
        {:error, :not_found}
      [{_, _}] ->
        {:ok, GenServer.call(Link.via_name(shortcode), :lookup)}
    end
  end

  # Private functions

  defp generate_shortcode do
    code = 6
      |> :crypto.strong_rand_bytes()
      |> Base.url_encode64()
      |> binary_part(0, 6)
      |> String.replace("-", "_")

    case Registry.lookup(@registry, code) do
      [{_, _}] ->
        generate_shortcode()
      [] ->
        code
    end
  end

  defp validate_shortcode(shortcode) do
    Regex.match?(~r/^[0-9a-zA-Z_]{4,}$/, shortcode)
  end
end
