# Solution to https://projecteuler.net/problem=27

Code.require_file("primes.ex")

defmodule Euler0027 do
	def prime_quadratic(a, b, n) do
		if Primes.prime?((n ** 2) + (a * n) + b) do
			prime_quadratic(a, b, n + 1)
		else
			{n, a * b}
		end
	end
	
	def highest_prime_quadratic() do
		elem((for a <- -999..999, b <- -999..999, do: prime_quadratic(a, b, 0)) |> Enum.max_by(fn t -> elem(t, 0) end), 1)
	end
end

IO.puts(Euler0027.highest_prime_quadratic)