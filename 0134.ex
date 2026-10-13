# Solution to https://projecteuler.net/problem=134

Code.require_file("primes.ex")

defmodule Euler0134 do
	def find_pair_connection(a, b, digits \\ 0, total \\ 0) do
		magnitude = 10**digits
		next_total = (for d <- 0..9, rem(magnitude * d * b + total, magnitude*10) == rem(a, magnitude*10), do: magnitude * d * b + total) |> List.first!()
		if rem(next_total, 10**((:math.log10(a) |> trunc()) + 1)) == a do
			next_total
		else
			find_pair_connection(a, b, digits + 1, next_total)
		end
	end
	
	def pair_connections(limit \\ 10**6) do
		primes = for n <- 5..(limit + trunc(:math.sqrt(limit))), Primes.prime?(n), do: n
		pairs = Enum.zip(primes, tl(primes)) |> Enum.filter(fn {a, _} -> a <= limit end)
		Enum.map(pairs, fn {a, b} -> find_pair_connection(a, b) end) |> Enum.sum()
	end
end

IO.inspect(Euler0134.pair_connections())