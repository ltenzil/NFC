defmodule FuelCalculator do
  import FuelCalculator.Shuttle
  import FuelCalculator.Validator

  @moduledoc """
  Documentation for `FuelCalculator`.
  """

  @doc """
    Help/1

    ## Examples
    iex> FuelCalculator.help
  """
  @spec help :: String.t()
  def help do
    "Try: FuelCalculator.calculate(28801, :land, :earth) \n " <>
      "or: FuelCalculator.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])"
  end

  @doc """
    Calculate/2

    used to calculate fuel required for a round trip
    ## Examples
    iex> FuelCalculator.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
    51898
  """
  @spec calculate(integer, list(tuple)) :: integer | String.t()
  def calculate(mass, paths) do
    validate(mass, paths)
    |> compute(mass)
  end

  @doc """
    Calculate/3
    
    used to calculate fuel required to perform single step, i.e land or launch
    ## Examples
    iex>  FuelCalculator.calculate(28801, :land, 9.807)
    13447
    iex>  FuelCalculator.calculate(28801, :land, :earth)
    13447
  """
  @spec calculate(integer, atom, integer) :: integer | String.t()
  def calculate(mass, mode, gravity) do
    validate(mass, [{mode, gravity}])
    |> compute(mass)
  end

  @spec compute(tuple, integer) :: integer | String.t()
  defp compute({:error, message}, _mass), do: message <> " \n " <> help()
  defp compute({:ok, []}, _mass), do: 0

  defp compute({:ok, paths}, mass) do
    [current_path | next_paths] = paths
    {mode, value} = current_path
    gravity = find_gravity(value)
    shuttle_weight = compute({:ok, next_paths}, mass)
    shuttle_weight + fuel_for_trip(mode, mass + shuttle_weight, gravity)
  end
end
