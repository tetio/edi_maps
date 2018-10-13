defmodule EdiMaps do
  require Record

  Record.defrecord :seg_def, qualifier: nil, min: nil, max: nil

  @type seg_def :: record(:seg_def, qualifier: String.t, min: integer, max: integer)

  def ask() do
    answer = IO.gets("Hola? ") |> String.trim |> String.downcase
    if answer not in ["llaminadures", "fum", "ella"] do
      IO.puts "Oops! no m'agrada #{answer}"
      ask()
    else
      IO.puts "Molt bé!!"
    end
  end

  def parse_definition(definition) do
    Enum.map(Enum.flat_map(definition, fn {_, d} -> String.split(d, ",") end), fn d2 ->  String.split(d2, "\.") end)
  end

  def validate_definition(definition) do
    Enum.flat_map(definition, fn l ->
      {q,b,c} = List.to_tuple(l)
      Enum.filter(
      [validate_qualifier(q),
      validate_integer(b),
      validate_integer(c)], &(&1 != nil))
    end)
  end

  defp validate_qualifier(q) do
    if !(is_bitstring(q) && ( String.starts_with?(String.downcase(q), "group")|| String.length(q) == 3)) do
      "Error in quelifier #{q}"
    end
  end

  defp validate_integer(i) do
    value = Integer.parse(i)
    if (value == :error) do
      "Error in integer #{i}"
    end
  end
end
