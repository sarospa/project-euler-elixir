# Solution to https://projecteuler.net/problem=16

defmodule Euler0016 do
	def sum_digits() do
		(2 ** 1000) |> Integer.to_string() |> String.graphemes() |> Enum.map(fn c -> String.to_integer(c) end) |> Enum.sum()
	end
end

IO.puts(Euler0016.sum_digits())