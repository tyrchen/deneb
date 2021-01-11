defmodule Deneb.Chart do
  @moduledoc """
  Vega-lite chart implementation
  """
  use TypedStruct

  alias Deneb.{Chart, Mark, Encoding, Projection, Transform, Utils}

  typedstruct do
    @typedoc "chart properties"
    field :mark, Mark.t() | nil, default: nil
    field :encoding, Encoding.t() | nil, default: nil
    field :projection, Projection.t() | nil, default: nil
    field :transform, Transform.t() | nil, default: nil
    field :raw, String.t() | map() | nil, default: nil
  end

  def new(raw) when is_binary(raw) or is_map(raw) do
    %Chart {
      raw: raw
    }
  end

  def new(mark, encoding, transform \\ nil, projection \\ nil) do
    %Chart {
      mark: mark,
      encoding: encoding,
      transform: transform,
      projection: projection
    }
  end

  def to_json(chart, base_chart_opts \\ [])
  def to_json(%Chart{} = chart, base_chart_opts), do: Utils.to_json(chart, base_chart_opts)
  def to_json(_chart, _base_chart_opts), do: raise "Please provide an Chart object to this function"

  def repeat(chart, repeat) do
    data = Chart.to_json(chart)
    Utils.encode(%{spec: data, repeat: repeat})
  end

  def layer(charts, base_chart_opts \\ []) do
    data = Utils.encode(base_chart_opts)
    Map.put(data, :layer, Enum.map(charts, &Utils.to_json/1))
  end

  def hconcat(charts, base_chart_opts \\ []) do
    data = Utils.encode(base_chart_opts)
    Map.put(data, :hconcat, Enum.map(charts, &Utils.to_json/1))
  end

  def vconcat(charts, base_chart_opts \\ []) do
    data = Utils.encode(base_chart_opts)
    Map.put(data, :vconcat, Enum.map(charts, &Utils.to_json/1))
  end

  def concat(charts, columns \\ 2, base_chart_opts \\ []) do
    data = Utils.encode(base_chart_opts)
    data
    |> Map.put(:columns, columns)
    |> Map.put(:concat, Enum.map(charts, &Chart.to_json/1))
  end
end
