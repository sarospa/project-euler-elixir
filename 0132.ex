# Solution to https://projecteuler.net/problem=132
# slow (slightly over a minute)

Code.require_file("primes.ex")

defmodule Euler0132 do
	def repunit?(n) do
		n in [1, 11, 111, 1111, 11111, 111111, 1111111, 11111111, 111111111, 1111111111]
	end

	def divisible_repunit(n, r \\ 0, total \\ 0) do
		digit = (for x <- 0..9, rem(x * n + r, 10) == 1, do: x) |> List.first!()
		term = n * digit + r
		if repunit?(term) do
			(Integer.to_string(term) |> String.length()) + total
		else
			divisible_repunit(n, div(term, 10), total + 1)
		end
	end
	
	def find_divisible_repunits(target \\ 10**9) do
		Stream.iterate(6, fn x -> x + 1 end)
			|> Stream.filter(fn x -> Primes.prime?(x) and rem(target, divisible_repunit(x)) == 0 end)
			|> Enum.take(40) |> Enum.sum()
	end
end

IO.puts(Euler0132.find_divisible_repunits())