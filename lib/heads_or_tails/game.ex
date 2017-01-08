defmodule HeadsOrTails.Game do
  defstruct coin: HeadsOrTails.Coin.new

  def new do
    %HeadsOrTails.Game{}
  end
  def new(coin) do
    %HeadsOrTails.Game{coin: coin}
  end

  def flip_coin(game) do
    new_coin = HeadsOrTails.Coin.new |> HeadsOrTails.Coin.flip
    %HeadsOrTails.Game{game | coin: new_coin }
  end

  def coin_value(%{coin: coin}) do
    coin.value
  end
end
