defmodule EdiMapsTest do
  use ExUnit.Case
  doctest EdiMaps
  import EdiMaps

  test "string and regex" do
    res = String.split("UNBZ.1.1,UNH.1.1,GROUP1.R.9,GROUP2.0.9,UNT.1.1,UNZ.1.1", ",")
    assert res != nil
    res2 = String.split("UNBZ.1.1", "\.")
    assert res2 != nil
  end


  test "string and regex more FP way" do
    res = Enum.map(String.split("UNBZ.1.1,UNH.1.1,GROUP1.R.9,GROUP2.0.9,UNT.1.1,UNZ.1.1", ","), fn s ->
      String.split(s, "\.")
    end)
    assert res != nil
  end

  test "silly game" do
    #assert ask == :ok
    assert 1 == 1
  end

  test "parse definition" do
    definition = %{
      "GROUP0" => "UNBZ.1.1,UNH.1.1,GROUP1.R.9,GROUP2.0.9,UNT.1.1,UNZ.1.1",
      "GROUP1" => "DTM.1.1,RFF.0.9,NAD.0.3",
      "GROUP2" => "CNI.1.1,NAD.0.5,GROUP3.0.99",
      "GROUP3" => "EQD.1.Z,NAD.0.5"
    }

    def_tree = parse_definition(definition)
    errors = validate_definition(def_tree)
    # assert defTree != nil
    assert Enum.count(errors) == 3
  end
end
