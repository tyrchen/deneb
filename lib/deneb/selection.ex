defmodule Deneb.Selection do
  @moduledoc """
  Vega-lite selection
  """
  use TypedStruct

  alias Deneb.{Selection, Utils}

  @allowed_selections [:single, :multi, :interval]

  typedstruct do
    @typedoc "mark properties"
    field :name, String.t()
    field :type, atom(), default: :interval
    field :encodings, [String.t()] | nil, default: nil
    field :fields, [String.t()] | nil, default: nil
    field :resolve, String.t() | nil, default: nil
    field :empty, String.t() | nil, default: "all"
    field :clear, String.t() | boolean() | nil, default: nil
    field :on, String.t() | nil, default: nil
    field :raw, String.t() | map() | nil, default: nil
  end

  def new(name, raw) when is_binary(raw) or is_map(raw) do
    %Selection {
      name: name,
      raw: raw
    }
  end

  def new(name, type \\ :interval, encodings \\ nil) do
    if type not in @allowed_selections do
      raise "Not supported type: #{type}"
    end

    %Selection {
      name: name,
      type: type,
      encodings: encodings
    }
  end

  def to_json(%Selection{} = selection) do
    name = selection.name
    sel = %{selection | name: nil}
    %{name => Utils.to_json(sel)}
  end
  def to_json(_selection), do: raise "Please provide a Selection object to this function"

end
