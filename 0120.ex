# Solution to https://projecteuler.net/problem=120

defmodule Euler0120 do
	def square_remainder(a, n) do
		rem((a - 1)**n + (a + 1)**n, a**2)
	end
	
	def find_square_remainder(a) do
		(for n <- 1..a*2//2, do: square_remainder(a, n)) |> Enum.max()
	end
	
	def find_square_remainders() do
		(for a <- 3..1000, do: find_square_remainder(a)) |> Enum.sum()
	end
end

IO.puts(Euler0120.find_square_remainders())