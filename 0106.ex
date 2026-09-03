# Solution to https://projecteuler.net/problem=106

import Bitwise

defmodule Euler0106 do
	def subset(list, bit_index) do
		Enum.with_index(list) |> Enum.filter(fn t -> rem(bit_index >>> elem(t, 1), 2) == 1 end)
			|> Enum.map(fn t -> elem(t, 0) end)
	end
	
	def all_subsets(list) do
		for k <- 1..(2**length(list)-1), do: subset(list, k)
	end
	
	def necessary_pair?(set1, set2) do
		(Enum.zip_with(set1, set2, fn n, m -> n > m end) |> Enum.uniq() |> length()) == 2
	end
	
	def necessary_subsets(size \\ 12) do
		subsets = all_subsets(for n <- 1..size, do: n)
		subset_pairs = for set1 <- subsets, set2 <- subsets,
			length(set1) == length(set2) and length(set1) > 1 and !Enum.any?(set1, fn x -> x in set2 end) and set1 < set2, do: {set1, set2}
		(for {set1, set2} <- subset_pairs, necessary_pair?(set1, set2), do: {set1, set2}) |> length()
	end
end

IO.inspect(Euler0106.necessary_subsets())