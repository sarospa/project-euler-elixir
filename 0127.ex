# Solution to https://projecteuler.net/problem=127
# slow (2-3 mins)

Code.require_file("primes.ex")

defmodule Euler0127 do
	@small_primes (for n <- 1..100, Primes.prime?(n), do: n)

	def prime_min(factors) do
		extras = Enum.filter(@small_primes, fn x -> x not in factors end) |> Enum.take(2)
		Enum.product(factors ++ extras)
	end

	def test() do
		candidates = for n <- 2..1000, prime_min(n) < 1000, do: n
		results = (for a <- candidates, b <- candidates, a < b, a + b < 1000, Factors.gcd(a, b) == 1,
			((Factors.factors(a) ++ Factors.factors(b) ++ Factors.factors(a + b)) |> Enum.uniq() |> Enum.product()) < a + b, do: {a, b, a+b, (Factors.factors(a) ++ Factors.factors(b) ++ Factors.factors(a + b)) |> Enum.uniq() |> Enum.sort()})
		(for b <- 2..1000, 1 + b < 1000, (Factors.factors(b) ++ Factors.factors(1 + b)) |> Enum.uniq() |> Enum.product() < 1 + b, do: {1, b, 1+b, ((Factors.factors(b) ++ 
			Factors.factors(1 + b)) |> Enum.uniq()) |> Enum.uniq() |> Enum.sort()}) ++ results
	end
	
	def find_abc_hits(target) do
		factors = for n <- 2..target, into: %{}, do: {n, Factors.factors(n) |> Enum.uniq()}
		candidates = for n <- 2..target, prime_min(factors[n]) < target, do: n
		partial_sum = (for a <- candidates, b <- candidates, a < b, a + b < target, Enum.all?(factors[a], fn x -> x not in factors[b] end),
			Enum.product(factors[a] ++ factors[b] ++ factors[a+b]) < a+b, do: a+b) |> Enum.sum()
		((for b <- 2..target, 1 + b < target, Enum.product(factors[b] ++ factors[1+b]) < 1+b, do: 1+b) |> Enum.sum()) + partial_sum
	end
end

IO.puts(Euler0127.find_abc_hits(120000))