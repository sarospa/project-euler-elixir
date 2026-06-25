# Solution to https://projecteuler.net/problem=15

Code.require_file("memoize.ex")

defmodule Euler0015 do
	def lattice_paths_unmem(t) do
		x = elem(t, 0)
		y = elem(t, 1)
		cond do
			x < 0 or y < 0 -> 0
			x == 0 and y == 0 -> 1
			true -> lattice_paths({x - 1, y}) + lattice_paths({x, y - 1})
		end
	end
	
	def lattice_paths(t) do
		Memoize.memoize_func(&lattice_paths_unmem/1).(t)
	end
end

IO.puts(Euler0015.lattice_paths({20, 20}))