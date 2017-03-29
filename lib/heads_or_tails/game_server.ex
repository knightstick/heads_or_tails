defmodule HeadsOrTails.GameServer do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def coin_value(server) do
    GenServer.call(server, {:coin_value})
  end

  def flip_coin(server) do
    GenServer.cast(server, {:flip_coin})
  end

  def place_bet(server, id, value, amount) do
    GenServer.cast(server, {:place_bet, id, value, amount})
  end

  def bet_table(server) do
    GenServer.call(server, {:bet_table})
  end


  def init(_) do
    {:ok, HeadsOrTails.Game.new}
  end

  def handle_call({:coin_value}, _, state) do
    value = HeadsOrTails.Game.coin_value(state)
    {:reply, value, state}
  end

  def handle_call({:bet_table}, _, state) do
    bet_table = state.bet_table
    {:reply, bet_table, state}
  end

  def handle_cast({:flip_coin}, state) do
    new_state = HeadsOrTails.Game.flip_coin(state)
    {:noreply, new_state}
  end

  def handle_cast({:place_bet, id, value, amount}, state) do
    new_state = HeadsOrTails.Game.place_bet(state, value, id, amount)
    {:noreply, new_state}
  end

  # Needed for testing purposes
  def handle_info(:stop, server), do: {:stop, :normal, server}
  def handle_info(_, state), do: {:noreply, state}
end
