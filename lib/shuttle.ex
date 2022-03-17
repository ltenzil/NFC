defmodule FuelCalculator.Shuttle do
  @planets %{earth: 9.807, mars: 3.711, moon: 1.62}

  @moduledoc """
  Documentation for `Shuttle`.
  """

  @doc """
    compute_consumption/3

    Used to calculate basic fuel requirements using formulas
    land: mass * gravity * 0.033 - 42
    launch: mass * gravity * 0.042 - 33
    ## Examples
    iex> FuelCalculator.Shuttle.compute_consumption(:land, 28801, 9.807)
  """

  @spec compute_consumption(atom, integer, float) :: float
  def compute_consumption(directive, mass, gravity) do
    mode = find_mode(directive)
    fuel = mass * gravity * mode.arg1 - mode.arg2
    floor(fuel)
  end

  @doc """
    fuel_for_trip/3

    Used to calculate fuel requirements a round trip, (i.e) extra fuel required as reserve
    ## Examples
    iex> FuelCalculator.Shuttle.fuel_for_trip(:land, 28801, 9.807)
  """
  @spec compute_consumption(atom, integer, float) :: float
  def fuel_for_trip(directive, mass, gravity) do
    fuel_required = compute_consumption(directive, mass, gravity)

    if fuel_required <= 0,
      do: 0,
      else: fuel_required + fuel_for_trip(directive, fuel_required, gravity)
  end

  defp find_mode(:land), do: %{arg1: 0.033, arg2: 42}
  defp find_mode(:launch), do: %{arg1: 0.042, arg2: 33}

  def find_gravity(value) do
    case @planets[value] do
      nil -> value
      gravity -> gravity
    end
  end
end
