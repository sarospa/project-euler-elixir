# Solution to https://projecteuler.net/problem=77

Code.require_file("primes.ex")

defmodule Euler0077 do
	def count_prime_sums(n, total, bound) do
		if total == n do
			1
		else
			(for m <- 1..bound, Primes.prime?(m), do: count_prime_sums(n, total + m, Enum.min([m, n - (total + m)]))) |> Enum.sum()
		end
	end
	
	def find_prime_sums(n \\ 10) do
		if count_prime_sums(n, 0, n - 1) > 5000 do
			n
		else
			find_prime_sums(n + 1)
		end
	end
end

IO.puts(Euler0077.find_prime_sums())