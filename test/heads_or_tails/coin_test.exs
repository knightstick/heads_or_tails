defmodule HeadsOrTailsCoinTest do
  use ExUnit.Case
  doctest HeadsOrTails

  alias HeadsOrTails.Coin, as: Coin

  test "new has nil value" do
    coin = Coin.new
    assert coin.value == nil
  end

  test "flipping coin" do
    coin = Coin.new |> Coin.flip
    assert Enum.member?([:heads, :tails], coin.value)
  end
end
