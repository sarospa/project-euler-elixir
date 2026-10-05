# Solution to https://projecteuler.net/problem=130

Code.require_file("primes.ex")

defmodule Euler0130 do
	def repunit?(n) do
		Integer.to_string(n) |> String.graphemes() |> Enum.all?(fn d -> d == "1" end)
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
	
	def find_composite_repunit() do
		Stream.iterate(2, fn x -> x + 1 end) |> Stream.filter(fn x -> rem(x, 5) != 0 and rem(x, 2) != 0 end)
			|> Stream.filter(fn x -> !Primes.prime?(x) end) |> Stream.filter(fn x -> rem(x-1, divisible_repunit(x)) == 0 end)
			|> Enum.take(25) |> Enum.sum()
	end
end

IO.puts(Euler0130.find_composite_repunit())