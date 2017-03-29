defmodule HeadsOrTailsGameServerTest do
  use ExUnit.Case, async: true

  alias HeadsOrTails.GameServer, as: GameServer

  setup do
    {:ok, server} = HeadsOrTails.GameServer.start
    on_exit(fn -> send(server, :stop) end)
    {:ok, server: server}
  end

  test "flip coin", context do
    assert(nil == GameServer.coin_value(context[:server]))

    GameServer.flip_coin(context[:server])
    value = GameServer.coin_value(context[:server])

    assert Enum.member?([:heads, :tails], value)
  end

  test "new game coin value" do
    game = HeadsOrTails.Game.new
    {:reply, value, _state} =
      GameServer.handle_call({:coin_value}, self(), game)

    assert value == nil
  end

  test "new server coin value", context do
    assert GameServer.coin_value(context[:server]) == nil
  end

  test "seeded game coin value" do
    heads_coin = HeadsOrTails.Coin.new(:heads)
    game = HeadsOrTails.Game.new(heads_coin)
    {:reply, value, _state} =
      GameServer.handle_call({:coin_value}, self(), game)

    assert value == :heads
  end

  test "placing a bet", context do
    GameServer.place_bet(context[:server], "123", :heads, 50)
    %HeadsOrTails.BetTable{heads: heads} =
      GameServer.bet_table(context[:server])

    assert heads == %{"123" => 50}
  end

  test "placing bets", context do
    GameServer.place_bet(context[:server], "123", :heads, 30)
    GameServer.place_bet(context[:server], "456", :heads, 10)
    GameServer.place_bet(context[:server], "123", :heads, 40)
    GameServer.place_bet(context[:server], "456", :heads, 20)
    GameServer.place_bet(context[:server], "123", :tails, 50)
    GameServer.place_bet(context[:server], "456", :tails, 40)

    %HeadsOrTails.BetTable{heads: heads, tails: tails} =
      GameServer.bet_table(context[:server])

    assert heads == %{"123" => 70, "456" => 30}
    assert tails == %{"123" => 50, "456" => 40}
  end
end
