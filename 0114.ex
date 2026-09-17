# Solution to https://projecteuler.net/problem=114

Code.require_file("memoize.ex")

defmodule Euler0114 do
	def count_block_combos_unmem(size) do
		results = for a <- 1..size//1, b <- 3..size//1, a < b - 1, do: count_block_combos(size - (b + 1))
		Enum.sum(results) + 1
	end
	
	def count_block_combos(size \\ 50) do
		Memoize.memoize_func(&count_block_combos_unmem/1).(size)
	end
end

IO.puts(Euler0114.count_block_combos())