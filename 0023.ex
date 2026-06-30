# Solution to https://projecteuler.net/problem=23

defmodule Euler0023 do
	def divisor_sum(n) do
		(for x <- 1..trunc(n ** 0.5), rem(n, x) == 0, do: (if x * x == n or x == 1 do x else x + (div(n, x)) end)) |> Enum.sum()
	end
	
	def abundant?(n) do
		divisor_sum(n) > n
	end
	
	def non_abundant_sums() do
		abundants = for n <- 1..28123, abundant?(n), do: n
		abundant_sums = for x <- abundants, y <- abundants, y >= x, x + y <= 28123, into: MapSet.new(), do: x + y
		(for n <- 1..28123, !Enum.member?(abundant_sums, n), do: n) |> Enum.sum()
	end
end

IO.puts(Euler0023.non_abundant_sums())