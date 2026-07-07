# Solution to https://projecteuler.net/problem=41

Code.require_file("primes.ex")

defmodule Euler0041 do
	def find_lex_permutation(list, target) do
		if length(list) == 1 do
			Enum.at(list, 0)
		else
			count = (for n <- 1..(length(list) - 1), do: n) |> Enum.product()
			term = Enum.at(list, div(target, count))
			term * (10 ** (length(list) - 1)) + find_lex_permutation(List.delete(list, term), rem(target, count))
		end
	end

	def gen_pandigital(list) do
		factorial = 1..length(list) |> Enum.product()
		for n <- 0..(factorial - 1), do: find_lex_permutation(list, n)
	end
	
	def pandigital_prime() do
		(for n <- 7..1//-1, do: gen_pandigital(for x <- n..1//-1, do: x)) |> List.flatten()
			|> Enum.find(fn n -> Primes.prime?(n) end)
	end
end

IO.puts(Euler0041.pandigital_prime())