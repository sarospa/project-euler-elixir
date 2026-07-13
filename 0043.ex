# Solution to https://projecteuler.net/problem=43

defmodule Euler0043 do
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
	
	def sub_divisibles() do
		gen_pandigital([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]) |> Enum.filter(fn p ->
			p >= 10**9 and
				(div(p, 10**6) |> rem(1000) |> rem(2)) == 0 and
				(div(p, 10**5) |> rem(1000) |> rem(3)) == 0 and
				(div(p, 10**4) |> rem(1000) |> rem(5)) == 0 and
				(div(p, 10**3) |> rem(1000) |> rem(7)) == 0 and
				(div(p, 10**2) |> rem(1000) |> rem(11)) == 0 and
				(div(p, 10**1) |> rem(1000) |> rem(13)) == 0 and
				(rem(p, 1000) |> rem(17)) == 0
		end) |> Enum.sum()
	end
end

IO.puts(Euler0043.sub_divisibles())