defmodule Deneb.Transform do
  @moduledoc """
  Vega-lite transform
  """
  use TypedStruct

  alias Deneb.{Transform, Utils}

  typedstruct do
    @typedoc "encoding properties"
    field :raw, String.t() | map() | nil, default: nil
  end

  def new(raw) when is_binary(raw) or is_map(raw) do
    %Transform {
      raw: raw
    }
  end

  def to_json(%Transform{} = transform), do: Utils.to_json(transform)
  def to_json(_transform), do: raise "Please provide an Transform object to this function"

end
