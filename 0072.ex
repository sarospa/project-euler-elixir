# Solution to https://projecteuler.net/problem=72

Code.require_file("primes.ex")

defmodule Euler0072 do
	def count_fractions() do
		target = 10**6
		Primes.sieve(target)
		(for n <- 2..target, do: Totient.totient(n)) |> Enum.sum()
	end
end

IO.puts(Euler0072.count_fractions())