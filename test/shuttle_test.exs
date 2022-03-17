defmodule FuelCalculator.ShuttleTest do
  use ExUnit.Case
  doctest FuelCalculator.Shuttle

  test "compute fuel requried for provided example" do
    mass = 28801
    gravity = 9.807
    directive = :land
    output = FuelCalculator.Shuttle.compute_consumption(directive, mass, gravity)
    assert output == 9278
  end

  test "compute trip fuel requried for provided example" do
    mass = 28801
    gravity = 9.807
    directive = :land
    output = FuelCalculator.Shuttle.fuel_for_trip(directive, mass, gravity)
    assert output == 13447
  end
end
