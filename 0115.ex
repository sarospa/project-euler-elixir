# Solution to https://projecteuler.net/problem=115

Code.require_file("memoize.ex")

defmodule Euler0115 do
	def count_block_combos_unmem({min, size}) do
		results = for a <- 1..size//1, b <- min..size//1, a <= b - (min - 1), do: count_block_combos({min, size - (b + 1)})
		Enum.sum(results) + 1
	end
	
	def count_block_combos(args) do
		Memoize.memoize_func(&count_block_combos_unmem/1).(args)
	end
	
	def find_min_combos(min \\ 50, target \\ 10**6) do
		Stream.iterate(1, fn x -> x + 1 end) |> Enum.find(fn x -> count_block_combos({min, x}) > target end)
	end
end

IO.puts(Euler0115.find_min_combos())