# Solution to https://projecteuler.net/problem=105

import Bitwise

defmodule Euler0105 do
	@sets File.read!("0105_sets.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
		|> Enum.map(fn line -> String.split(line, ",") |> Enum.map(fn num -> String.to_integer(num) end) end)

	def subset_sum(list, bit_index) do
		Enum.with_index(list) |> List.foldl(0, fn t, acc ->
				n = elem(t, 0)
				i = elem(t, 1)
				if rem(bit_index >>> i, 2) == 1 do
					acc + n
				else
					acc
				end
			end)
	end

	def disjoint_sums?(list) do
		sums = for n <- 1..(2**length(list)-1), do: subset_sum(list, n)
		length(sums) == length(Enum.uniq(sums))
	end
	
	def ordered_size_sums?(list) do
		tests = for n <- 2..div(length(list), 2)+1//1, do: (Enum.take(list, n) |> Enum.sum()) > (Enum.drop(list, length(list) - (n - 1)) |> Enum.sum())
		Enum.all?(tests)
	end
	
	def count_special_sets() do
		(for set <- @sets, disjoint_sums?(set |> Enum.sort()) and ordered_size_sums?(set |> Enum.sort()), do: set)
			|> List.flatten() |> Enum.sum()
	end
end

IO.puts(Euler0105.count_special_sets())