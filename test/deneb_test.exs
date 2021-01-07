defmodule DenebTest do
  use ExUnit.Case
  doctest Deneb

  test "greets the world" do
    assert Deneb.hello() == :world
  end
end
