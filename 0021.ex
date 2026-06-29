# Solution to https://projecteuler.net/problem=21

defmodule Euler0021 do
	def divisor_sum(n) do
		(for x <- 1..trunc(n ** 0.5), rem(n, x) == 0, do: (if x * x == n or x == 1 do x else x + (div(n, x)) end)) |> Enum.sum()
	end
	
	def amicable?(n) do
		first = divisor_sum(n)
		second = divisor_sum(first)
		n == second and n != first
	end
	
	def sum_amicable() do
		(for n <- 1..10000, amicable?(n), do: n) |> Enum.sum()
	end
end

IO.puts(Euler0021.sum_amicable())