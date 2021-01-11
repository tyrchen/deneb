defmodule Deneb.Chart do
  @moduledoc """
  Vega-lite chart implementation
  """
  use TypedStruct

  alias Deneb.{Chart, Mark, Encoding, Projection, Selection, Transform, Utils}

  typedstruct do
    @typedoc "chart properties"
    field :mark, Mark.t() | nil, default: nil
    field :encoding, Encoding.t() | nil, default: nil
    field :projection, Selection.t() | nil, default: nil
    field :selection, Projection.t() | nil, default: nil
    field :transform, Transform.t() | nil, default: nil
    field :raw, String.t() | map() | nil, default: nil
  end

  def new(raw) when is_binary(raw) or is_map(raw) do
    %Chart {
      raw: raw
    }
  end

  def new(mark, encoding, opts \\ []) do
    selection = opts[:selection] || nil
    transform = opts[:transform] || nil
    projection = opts[:projection] || nil
    %Chart {
      mark: mark,
      encoding: encoding,
      selection: selection,
      transform: transform,
      projection: projection
    }
  end

  def to_json(chart, base_chart_opts \\ [])
  def to_json(%Chart{} = chart, base_chart_opts) do
    result = chart
    |> Utils.to_map()
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      cond do
        is_struct(v) -> Map.put(acc, k, apply(v.__struct__, :to_json, [v]))
        is_nil(v) -> acc
        true -> Map.put(acc, k, v)
      end

    end)
    Map.merge(result, Utils.encode(base_chart_opts))
  end
  def to_json(_chart, _base_chart_opts), do: raise "Please provide an Chart object to this function"

  def repeat(chart, repeat, base_chart_opts \\ []) do
    data = Chart.to_json(chart, base_chart_opts)
    Utils.encode(%{spec: data, repeat: repeat})
  end

  def layer(charts, base_chart_opts \\ []) do
    data = Utils.encode(base_chart_opts)
    Map.put(data, :layer, charts_to_json(charts))
  end

  def hconcat(charts, base_chart_opts \\ []) do
    data = Utils.encode(base_chart_opts)
    Map.put(data, :hconcat, charts_to_json(charts))
  end

  def vconcat(charts, base_chart_opts \\ []) do
    data = Utils.encode(base_chart_opts)
    Map.put(data, :vconcat, charts_to_json(charts))
  end

  def concat(charts, columns \\ 2, base_chart_opts \\ []) do
    data = Utils.encode(base_chart_opts)
    data
    |> Map.put(:columns, columns)
    |> Map.put(:concat, Enum.map(charts, &Chart.to_json/1))
  end

  # private functions
  defp charts_to_json(charts) do
    Enum.map(charts, fn chart ->
      case is_struct(chart) do
        true -> apply(chart.__struct__, :to_json, [chart])
        _ -> chart
      end
    end)
  end
end
