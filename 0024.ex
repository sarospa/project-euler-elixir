# Solution to https://projecteuler.net/problem=24

defmodule Euler0024 do
	def find_lex_permutation(list, target) do
		if length(list) == 1 do
			Enum.at(list, 0)
		else
			count = (for n <- 1..(length(list) - 1), do: n) |> Enum.product()
			term = Enum.at(list, div(target, count))
			term * (10 ** (length(list) - 1)) + find_lex_permutation(List.delete(list, term), rem(target, count))
		end
	end
end

IO.puts(Euler0024.find_lex_permutation((for n <- 0..9, do: n), 999999))