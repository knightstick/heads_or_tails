defmodule HeadsOrTails.BetTable do
  defstruct heads: %{}, tails: %{}

  def new do
    %HeadsOrTails.BetTable{}
  end

  def bet(table = %HeadsOrTails.BetTable{heads: heads}, id, :heads, amount) do
    %HeadsOrTails.BetTable{ table | heads: bet_amount(heads, id, amount) }
  end

  def bet(table = %HeadsOrTails.BetTable{tails: tails}, id, :tails, amount) do
    %HeadsOrTails.BetTable{ table | tails: bet_amount(tails, id, amount) }
  end

  defp bet_amount(map, id, amount) do
    Map.merge(map, %{id => amount}, fn _k, v1, v2 ->
      v1 + v2
    end)
  end
end
