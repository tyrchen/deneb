defmodule Deneb.Projection do
  @moduledoc """
  Vega-lite projection
  """
  use TypedStruct

  alias Deneb.{Projection, Utils}

  typedstruct do
    @typedoc "encoding properties"
    field :raw, String.t() | map() | nil, default: nil
  end

  def new(raw) when is_binary(raw) or is_map(raw) do
    %Projection {
      raw: raw
    }
  end

  def to_json(%Projection{} = projection), do: Utils.to_json(projection)
  def to_json(_projection), do: raise "Please provide an Projection object to this function"

end
