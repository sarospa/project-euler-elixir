# Solution to https://projecteuler.net/problem=179
# slow (~10 min)

Code.require_file("primes.ex")

defmodule Euler0179 do
	def calc_same_divisors(limit \\ 10**7) do
		factors = for n <- 2..limit, do: length(Factors.proper_factors(n))
		{_, count} = List.foldl(factors, {0, 0}, fn f, {prev, count} -> if f == prev do {f, count+1} else {f, count} end end)
		count
	end
end

IO.puts(Euler0179.calc_same_divisors())