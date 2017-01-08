defmodule HeadsOrTails.Game do
  defstruct coin: HeadsOrTails.Coin.new

  def new do
    %HeadsOrTails.Game{}
  end

  def flip_coin(game) do
    new_coin = HeadsOrTails.Coin.new |> HeadsOrTails.Coin.flip
    %HeadsOrTails.Game{game | coin: new_coin }
  end
end
