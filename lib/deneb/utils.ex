defmodule Deneb.Utils do
  @moduledoc """
  Utility functions
  """

  def to_json(struct, base_chart_opts \\ []) do
    opts = encode(base_chart_opts)
    raw = Map.get(struct, :raw)
    data = cond do
      is_map(raw) -> struct.raw
      is_binary(raw) -> Jason.decode!(struct.raw)
      true -> struct |> to_map() |> encode()
    end
    Map.merge(data, opts)
  end

  def to_map(struct) when is_struct(struct) do
    struct |> Map.from_struct() |> Map.drop([:__meta__, :__struct__, :raw])
  end

  def to_map(map), do: map

  def encode(struct) when is_struct(struct), do: apply(struct.__struct__, :to_json, [struct])

  def encode(map) when is_map(map) or is_list(map) do
    Enum.reduce(map, %{}, fn {k, v}, acc ->
      cond do
        v == nil -> acc
        is_struct(v) -> Map.put(acc, k, apply(v.__struct__, :to_json, [v]))
        true -> Map.put(acc, k, v)
      end
    end)
  end
end
