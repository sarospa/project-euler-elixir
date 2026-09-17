# Solution to https://projecteuler.net/problem=116

Code.require_file("memoize.ex")

defmodule Euler0116 do
	def count_block_combos_unmem({min, size}) do
		results = for a <- 1..size//1, a + min <= size + 1, do: count_block_combos({min, size - (a + min - 1)})
		Enum.sum(results) + 1
	end
	
	def count_block_combos(args) do
		Memoize.memoize_func(&count_block_combos_unmem/1).(args)
	end
	
	def count_colored_block_combos(size \\ 50) do
		red = count_block_combos({2, size}) - 1
		green = count_block_combos({3, size}) - 1
		blue = count_block_combos({4, size}) - 1
		red + green + blue
	end
end

IO.puts(Euler0116.count_colored_block_combos())