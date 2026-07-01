# Solution to https://projecteuler.net/problem=32

defmodule Euler0032 do
	def find_lex_permutation(list, target) do
		if length(list) == 1 do
			Enum.at(list, 0)
		else
			count = (for n <- 1..(length(list) - 1), do: n) |> Enum.product()
			term = Enum.at(list, div(target, count))
			term * (10 ** (length(list) - 1)) + find_lex_permutation(List.delete(list, term), rem(target, count))
		end
	end
	
	def check_pandigital_product(digits, mult_pos, equal_pos) do
		term_a = div(digits, 10 ** (9 - mult_pos))
		term_b = div(digits, 10 ** (9 - equal_pos)) |> rem(10 ** (equal_pos - mult_pos))
		product = rem(digits, 10 ** (9 - equal_pos))
		if term_a * term_b == product do
			product
		else
			0
		end
	end
	
	def pandigital_products() do
		pandigitals = for n <- 0..(Enum.product(1..9) - 1), do: find_lex_permutation((for x <- 1..9, do: x), n)
		Enum.map(pandigitals, fn p ->
			for m <- 1..8, e <- 1..8, e > m, do: check_pandigital_product(p, m, e)
		end) |> List.flatten() |> Enum.uniq() |> Enum.sum()
	end
end

IO.puts(Euler0032.pandigital_products())