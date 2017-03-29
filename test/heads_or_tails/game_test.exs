defmodule HeadsOrTailsGameTest do
  use ExUnit.Case
  doctest HeadsOrTails

  alias HeadsOrTails.Game, as: Game

  test "has a new unflipped coin" do
    %{coin: coin} = Game.new
    assert coin.value == nil
  end

  test "flipping coin" do
    %{coin: coin} = Game.new |> Game.flip_coin
    refute coin.value == nil
  end

  test "getting value" do
    value = Game.new |> Game.coin_value
    assert value == nil
    value = Game.new |> Game.flip_coin |> Game.coin_value
    refute value == nil
  end

  test "creating with a coin" do
    tails_coin = HeadsOrTails.Coin.new(:tails)
    value = tails_coin |> Game.new |> Game.coin_value
    assert value == :tails
  end

  test "has an empty bet table" do
    %{bet_table: %{heads: heads, tails: tails}} = Game.new
    assert heads == %{}
    assert tails == %{}
  end

  test "can place a bet" do
    game = Game.new |> Game.place_bet(:heads, "123", 50)
    %{heads: heads, tails: tails} = game.bet_table
    assert Map.get(heads, "123") == 50
    assert Map.get(tails, "123") == nil
  end

  test "can place bets" do
    game = Game.new
           |> Game.place_bet(:heads, "123", 30)
           |> Game.place_bet(:heads, "123", 40)
           |> Game.place_bet(:tails, "123", 50)

    %{heads: heads, tails: tails} = game.bet_table
    assert Map.get(heads, "123") == 70
    assert Map.get(tails, "123") == 50
  end
end
