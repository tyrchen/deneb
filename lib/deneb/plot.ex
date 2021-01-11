defmodule Deneb.Plot do
  @moduledoc """
  Typical plotting tools
  """
  alias Deneb.{Chart, Encoding, Mark, Selection}

  def candlestick(data, opts \\ [])
  def candlestick({:ok, data}, opts), do: candlestick(data, opts)
  def candlestick(data, opts) do
    default = %{date: "date", open: "open", close: "close", low: "low", high: "high", volumn: nil, width: 800, height1: 400, height2: 50}
    config = Map.merge(default, Enum.into(opts, %{}))
    xaxis = %{
      axis: %{format: "%Y/%m/%d", labelAngle: -45},
      field: config.date,
      type: "temporal"
    }
    encoding = %{
      color: %{condition: %{test: "datum.#{config.open} < datum.#{config.close}", value: "#06982d"}, value: "#ae1325"},
      x: Map.merge(xaxis, %{scale: %{domain: %{selection: "brush"}}, axis: %{labels: false}}),
      y: %{scale: %{zero: false}, type: "quantitative"}
    }
    chart1 = Chart.new(Mark.new(:rule), Encoding.new(%{y: %{field: config.low}, y2: %{field: config.high}}))
    chart2 = Chart.new(Mark.new(:bar, true), Encoding.new(%{y: %{field: config.open}, y2: %{field: config.close}}))
    chart_candle_stick = Chart.layer([chart1, chart2], [encoding: encoding, width: config.width, height: config.height1])

    selection = Selection.new("brush", :interval, ["x"])
    y_field = case config[:volumn] do
      nil -> config.close
      volumn -> volumn
    end
    encoding = Encoding.new(%{x: xaxis, y: %{field: y_field, type: "quantitative"}})
    chart_volumes = Chart.layer([Chart.new(Mark.new(:line), encoding, selection: selection)], [width: config.width, height: config.height2])

    chart = Chart.vconcat([chart_candle_stick, chart_volumes])
    Deneb.to_json(chart, data)
  end

end
