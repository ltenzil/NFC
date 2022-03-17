defmodule FuelCalculator.Validator do
  @directives [:land, :launch]
  @planets [:earth, :mars, :moon]

  def validate(mass, _paths) when not is_integer(mass) or mass <= 0 do
    {:error, "Invalid input: mass"}
  end

  def validate(_mass, paths) when not is_list(paths) do
    {:error, "Invalid input: paths"}
  end

  def validate(_mass, paths) when is_list(paths) do
    if Enum.all?(paths, fn path ->
         is_tuple(path) &&
           validate_directives(path) &&
           validate_gravity(path)
       end),
       do: {:ok, paths},
       else: {:error, "Invalid Directive"}
  end

  defp validate_directives({mode, _gravity}), do: Enum.member?(@directives, mode)

  defp validate_gravity({_mode, gravity}) do
    is_float(gravity) || Enum.member?(@planets, gravity)
  end
end
