defmodule HeadsOrTails.Coin do
  defstruct value: nil

  def new do
    %HeadsOrTails.Coin{}
  end
  def new(value) do
    %HeadsOrTails.Coin{value: value}
  end

  def flip(_coin) do
    %HeadsOrTails.Coin{value: get_random_value()}
  end

  defp get_random_value do
    Enum.at([:heads, :tails], :rand.uniform(2) - 1)
  end
end
