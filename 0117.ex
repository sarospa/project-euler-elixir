# Solution to https://projecteuler.net/problem=117

Code.require_file("memoize.ex")

defmodule Euler0117 do
	def count_block_combos_unmem({min, max, size}) do
		results = for a <- 1..size//1, b <- (a + min - 1)..(a + max - 1)//1, b <= size, do: count_block_combos({min, max, size - b})
		Enum.sum(results) + 1
	end
	
	def count_block_combos(args \\ {2, 4, 50}) do
		Memoize.memoize_func(&count_block_combos_unmem/1).(args)
	end
end

IO.puts(Euler0117.count_block_combos())