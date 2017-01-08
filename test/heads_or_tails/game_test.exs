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
end
