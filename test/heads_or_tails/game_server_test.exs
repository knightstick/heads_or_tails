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
      GameServer.handle_call({:coin_value}, self, game)

    assert value == nil
  end

  test "seeded game coin value" do
    heads_coin = HeadsOrTails.Coin.new(:heads)
    game = HeadsOrTails.Game.new(heads_coin)
    {:reply, value, _state} =
      GameServer.handle_call({:coin_value}, self, game)

    assert value == :heads
  end
end
