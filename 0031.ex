# Solution to https://projecteuler.net/problem=31

defmodule Euler0031 do
	def count_coin_sums(coins, value) do
		cond do
			value == 0 -> 1
			value < 0 -> 0
			true -> (for i <-  0..(length(coins) - 1), do: count_coin_sums(Enum.drop(coins, i), value - Enum.at(coins, i))) |> Enum.sum()
		end
	end
end

IO.puts(Euler0031.count_coin_sums([200, 100, 50, 20, 10, 5, 2, 1], 200))