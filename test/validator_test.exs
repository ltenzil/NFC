defmodule FuelCalculator.ValidatorTest do
  use ExUnit.Case
  doctest FuelCalculator.Validator

  test "should fail with invalid inputs" do
    {status, _output} = FuelCalculator.Validator.validate(:land, "hello")
    assert status == :error
  end

  test "should fail with invalid path" do
    {_status, output} = FuelCalculator.Validator.validate(28801, "hello")
    assert output == "Invalid input: paths"
  end

  test "should fail with invalid mode" do
    {_status, output} = FuelCalculator.Validator.validate(28801, [{"land", 12}])
    assert output == "Invalid Directive"
  end

  test "should return path with valid input" do
    {_status, output} = FuelCalculator.Validator.validate(28801, [{:land, :earth}])
    assert output == [{:land, :earth}]
  end
end
