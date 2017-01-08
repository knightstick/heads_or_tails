defmodule HeadsOrTailsGameTest do
  use ExUnit.Case
  doctest HeadsOrTails

  alias HeadsOrTails.Game, as: Game

  test "has a new unflipped coin" do
    game = Game.new
    %{coin: coin} = game
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
    value = Game.new(tails_coin) |> Game.coin_value
    assert value == :tails
  end
end
