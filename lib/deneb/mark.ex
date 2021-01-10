defmodule Deneb.Mark do
  @moduledoc """
  Vega-lite mark
  """
  use TypedStruct

  alias Deneb.{Mark, Utils}
  @allowed_marks [:bar, :circle, :square, :tick, :line, :area, :point, :geoshape, :rule, :text, :boxplot, :errorband, :errorbar, :pie]

  typedstruct do
    @typedoc "mark properties"
    field :type, atom() | nil, default: nil
    field :tooltip, integer() | String.t() | boolean() | nil, default: nil
    field :raw, String.t() | map() | nil, default: nil
  end

  def new(raw) when is_binary(raw) or is_map(raw) do
    %Mark {
      raw: raw
    }
  end

  def new(type, tooltip \\ nil) do
    if type not in @allowed_marks do
      raise "Not supported type: #{type}"
    end

    %Mark {
      type: type,
      tooltip: tooltip
    }
  end

  def to_json(%Mark{} = mark), do: Utils.to_json(mark)
  def to_json(_mark), do: raise "Please provide a Mark object to this function"

end
