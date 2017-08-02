defmodule Elastix.Index do
  @moduledoc """
  """
  alias Elastix.HTTP

  @doc false
  def create(elastic_url, name, data) do
    elastic_url <> make_path(name)
    |> HTTP.put(Poison.encode!(data))
    |> process_response
  end

  @doc false
  def delete(elastic_url, name) do
    elastic_url <> make_path(name)
    |> HTTP.delete
    |> process_response
  end

  @doc false
  def get(elastic_url, name) do
    elastic_url <> make_path(name)
    |> HTTP.get
    |> process_response
  end

  @doc false
  def exists?(elastic_url, name) do
    request = elastic_url <> make_path(name)
      |> HTTP.head
      |> process_response

    case request.status_code do
      200 -> true
      404 -> false
    end
  end

  @doc false
  def refresh(elastic_url, name) do
    elastic_url <> make_path(name) <> make_path("_refresh")
    |> HTTP.post("")
    |> process_response
  end

  @doc false
  def new_aliases(elastic_url, body) do
    elastic_url <> "/_aliases"
    |> HTTP.post(Poison.encode!(body))
    |> process_response
  end

  @doc false
  def create_alias(elastic_url, index, alias_name, body \\ %{}) do
    elastic_url <> "/#{index}/_alias/#{alias_name}"
    |> HTTP.put(Poison.encode!(body))
    |> process_response
  end

  @doc false
  def delete_alias(elastic_url, index, alias_name) do
    elastic_url <> "/#{index}/_alias/#{alias_name}"
    |> HTTP.delete
    |> process_response
  end

  @doc false
  def get_alias(elastic_url, index, alias_name) do
    elastic_url <> "/#{index}/_alias/#{alias_name}"
    |> HTTP.get
    |> process_response
  end

  @doc false
  def get_alias(elastic_url, alias_name) do
    elastic_url <> "/_alias/#{alias_name}"
    |> HTTP.get
    |> process_response
  end

  @doc false
  def make_path(name) do
    "/#{name}"
  end

  @doc false
  defp process_response({_, response}), do: response
end
