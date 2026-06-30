# Solution to https://projecteuler.net/problem=26

defmodule Euler0026 do
	def reciprocal_chain(n, top, chain) do
		term = div(top * 10, n)
		next_top = rem(top * 10, n)
		cond do
			next_top == 0 -> 0
			term > 0 and Enum.member?(chain, {next_top, term}) -> Enum.find_index(chain, fn x -> x == {next_top, term} end) + 1
			true -> reciprocal_chain(n, next_top, [{next_top, term} | chain])
		end
	end
	
	def longest_chain() do
		(for n <- 2..999, do: n) |> List.foldr(1, fn acc, n -> if reciprocal_chain(acc, 1, []) < reciprocal_chain(n, 1, []) do n else acc end end)
	end
end

IO.puts(Euler0026.longest_chain())