# Solution to https://projecteuler.net/problem=7

defmodule Euler0007 do
	def findPrimes(primes, n) do
		cond do
			length(primes) == 10001 -> List.first(primes)
			Enum.all?(Enum.map(primes, fn p -> rem(n, p) != 0 end)) -> findPrimes([n | primes], n + 1)
			true -> findPrimes(primes, n + 1)
		end
	end
end

IO.puts(Euler0007.findPrimes([], 2))