# Solution to https://projecteuler.net/problem=119

defmodule Euler0119 do
	def digit_sum(n) do
		Integer.to_string(n) |> String.graphemes() |> Enum.map(fn s -> String.to_integer(s) end) |> Enum.sum()
	end

	def find_digit_power_sums() do
		(for a <- 2..1000, b <- 2..100, digit_sum(a**b) == a, do: a**b) |> Enum.sort() |> Enum.at(29)
	end
end

IO.puts(Euler0119.find_digit_power_sums())