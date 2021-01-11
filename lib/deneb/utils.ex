defmodule Deneb.Utils do
  @moduledoc """
  Utility functions
  """

  def to_json(struct, base_chart_opts \\ []) do
    opts = encode(base_chart_opts)
    data = cond do
      is_map(struct.raw) -> struct.raw
      is_binary(struct.raw) -> Jason.decode!(struct.raw)
      true -> encode(struct)
    end
    Map.merge(data, opts)
  end

  def encode(struct) when is_struct(struct) do
    map = struct |> Map.from_struct() |> Map.drop([:__meta__, :__struct__, :raw])
    encode(map)
  end

  def encode(map) when is_map(map) or is_list(map) do
    Enum.reduce(map, %{}, fn {k, v}, acc ->
      cond do
        v == nil -> acc
        is_struct(v) -> Map.put(acc, k, to_json(v))
        true -> Map.put(acc, k, v)
      end
    end)
  end
end
