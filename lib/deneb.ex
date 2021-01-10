defmodule Deneb do
  @moduledoc """
  Generate vega-lite charts
  """
  @formats [:json, :csv, :tsv, :dsv, :url]
  @schema "https://vega.github.io/schema/vega-lite/v4.json"

  def to_json(data, spec, format \\ :csv, delimiter \\ nil) do
    spec
    |> Map.put(:data, to_data_json(data, format, delimiter))
    |> Map.put(:"$schema", @schema)
  end

  defp to_data_json(data, format, delimeter) do
    if format not in @formats do
      raise "Unsupported data format #{format}"
    end

    case format do
      :url -> %{url: data}
      :json -> %{values: data, format: %{type: "json"}}
      :csv -> %{values: data, format: %{type: "csv"}}
      :tsv -> %{values: data, format: %{type: "tsv"}}
      :dsv -> %{values: data, format: %{type: "dsv", delimiter: delimeter}}
    end
  end
end
