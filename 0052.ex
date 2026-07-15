# Solution to https://projecteuler.net/problem=52

defmodule Euler0052 do
	def permutation?(n, m) do
		(Integer.to_string(n) |> String.graphemes |> Enum.sort()) == (Integer.to_string(m) |> String.graphemes |> Enum.sort())
	end
	
	def find_permuted_multiples(n) do
		if Enum.zip_with(2..5, [n, n, n, n, n], &(&1 * &2)) |> Enum.map(&(permutation?(n, &1))) |> Enum.all?() do
			n
		else
			find_permuted_multiples(n + 1)
		end
	end
end

IO.puts(Euler0052.find_permuted_multiples(1))