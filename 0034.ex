# Solution to https://projecteuler.net/problem=34

defmodule Euler0034 do
	def factorial(n) do
		cond do
			n == 0 -> 1
			n == 1 -> 1
			true -> Enum.product(1..n)
		end
	end

	def check_factorial_sum(n) do
		(Integer.to_string(n) |> String.graphemes() |> Enum.map(fn d -> factorial(String.to_integer(d)) end) |> Enum.sum()) == n
	end
	
	def find_factorial_sums() do
		(for n <- 10..(factorial(9) * 7), check_factorial_sum(n), do: n) |> Enum.sum()
	end
end

IO.puts(Euler0034.find_factorial_sums())