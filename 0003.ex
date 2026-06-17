# Solution to https://projecteuler.net/problem=3

defmodule Euler0003 do
	def findLargestPrimeFactor(n, x) do
		cond do
			rem(n, x) == 0 -> findLargestPrimeFactor(div(n, x), x)
			rem(n, x) != 0 && x * x < n -> findLargestPrimeFactor(n, x + 1)
			rem(n, x) != 0 && x * x >= n -> n
		end
	end
end

IO.puts(Euler0003.findLargestPrimeFactor(600851475143, 2))