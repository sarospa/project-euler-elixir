# Solution to https://projecteuler.net/problem=30

defmodule Euler0030 do
	def digit_fifth_power_sum(n) do
		Integer.to_string(n) |> String.graphemes |> Enum.map(fn x -> String.to_integer(x) ** 5 end) |> Enum.sum()
	end
	
	def self_sums() do
		(for n <- 10..((9 ** 5) * 6), digit_fifth_power_sum(n) == n, do: n) |> Enum.sum()
	end
end

IO.puts(Euler0030.self_sums())