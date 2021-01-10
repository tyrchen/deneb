defmodule Deneb.Encoding do
  @moduledoc """
  Vega-lite encoding
  """
  use TypedStruct

  alias Deneb.{Encoding, Utils}

  typedstruct do
    @typedoc "encoding properties"
    field :raw, String.t() | map() | nil, default: nil
  end

  def new(raw) when is_binary(raw) or is_map(raw) do
    %Encoding {
      raw: raw
    }
  end

  def to_json(%Encoding{} = encoding), do: Utils.to_json(encoding)
  def to_json(_encoding), do: raise "Please provide an Encoding object to this function"

end
