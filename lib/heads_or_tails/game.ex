defmodule HeadsOrTails.Game do
  defstruct coin: HeadsOrTails.Coin.new, bet_table: HeadsOrTails.BetTable.new

  def new do
    %HeadsOrTails.Game{}
  end
  def new(coin) do
    %HeadsOrTails.Game{coin: coin}
  end
  def new(coin, bet_table) do
    %HeadsOrTails.Game{coin: coin, bet_table: bet_table}
  end

  def flip_coin(game) do
    new_coin = HeadsOrTails.Coin.new |> HeadsOrTails.Coin.flip
    %HeadsOrTails.Game{game | coin: new_coin }
  end

  def coin_value(%{coin: coin}) do
    coin.value
  end

  # Struct for a bet?
  def place_bet(%HeadsOrTails.Game{coin: coin, bet_table: table},
    value, id, amount) do
    table = HeadsOrTails.BetTable.bet(table, id, value, amount)
    HeadsOrTails.Game.new(coin, table)
  end
end
