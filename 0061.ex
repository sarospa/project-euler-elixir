# Solution to https://projecteuler.net/problem=61

Code.require_file("helper.ex")

defmodule Euler0061 do
	def cycle_pair?(n, m) do
		div(n, 100) == rem(m, 100)
	end
	
	def find_pairs_in_list(n, list) do
		for m <- list, cycle_pair?(n, m), do: m
	end

	def find_pairs_in_lists(cycle, lists) do
		if length(lists) == 0 do
			if cycle_pair?(List.first(cycle), List.last(cycle)) do
				Enum.sum(cycle)
			else
				nil
			end
		else
			results = (for list <- lists, do: (for n <- list, cycle_pair?(List.first(cycle), n), do: find_pairs_in_lists([n | cycle], List.delete(lists, list))))
				|> List.flatten() |> Enum.filter(&(&1))
			if length(results) == 0 do
				nil
			else
				List.first(results)
			end
		end
	end

	def find_cyclical_numbers() do
		tri = for n <- 1000..9999, Helper.triangular?(n), do: n
		sq = for n <- 1000..9999, Helper.square?(n), do: n
		pent = for n <- 1000..9999, Helper.pentagonal?(n), do: n
		hex = for n <- 1000..9999, Helper.hexagonal?(n), do: n
		hept = for n <- 1000..9999, Helper.heptagonal?(n), do: n
		oct = for n <- 1000..9999, Helper.octagonal?(n), do: n
		(for n <- tri, do: find_pairs_in_lists([n], [sq, pent, hex, hept, oct])) |> List.flatten() |> Enum.filter(&(&1)) |> List.first()
	end
end

IO.puts(Euler0061.find_cyclical_numbers())