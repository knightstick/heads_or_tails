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


  def init(_) do
    {:ok, HeadsOrTails.Game.new}
  end

  def handle_call({:coin_value}, _, state) do
    value = HeadsOrTails.Game.coin_value(state)
    {:reply, value, state}
  end

  def handle_cast({:flip_coin}, state) do
    new_state = HeadsOrTails.Game.flip_coin(state)
    {:noreply, new_state}
  end

  # Needed for testing purposes
  def handle_info(:stop, server), do: {:stop, :normal, server}
  def handle_info(_, state), do: {:noreply, state}
end
