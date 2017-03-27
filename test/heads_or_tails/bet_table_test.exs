defmodule HeadsOrTailsBetTableTest do
  use ExUnit.Case
  doctest HeadsOrTails

  alias HeadsOrTails.BetTable, as: BetTable

  test "has no bets when new" do
    table = BetTable.new
    %{heads: head_bets, tails: tails_bets} = table

    assert head_bets == %{}
    assert tails_bets == %{}
  end

  test "adding heads bets" do
    table = BetTable.new
    bets = BetTable.bet(table, "123", :heads, 10)

    %{heads: heads_bets} = bets
    assert Map.get(heads_bets, "123") == 10

    bets = BetTable.bet(bets, "123", :heads, 20)

    %{heads: heads_bets} = bets
    assert Map.get(heads_bets, "123") == 30
  end

  test "adding tails bets" do
    table = BetTable.new
    bets = BetTable.bet(table, "123", :tails, 10)

    %{tails: tails_bets} = bets
    assert Map.get(tails_bets, "123") == 10

    bets = BetTable.bet(bets, "123", :tails, 20)

    %{tails: tails_bets} = bets
    assert Map.get(tails_bets, "123") == 30
  end
end