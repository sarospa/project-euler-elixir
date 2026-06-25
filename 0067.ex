# Solution to https://projecteuler.net/problem=67

Code.require_file("memoize.ex")

defmodule Euler0067 do
	def find_pyramid_sum() do
		grid = File.read!("0067_triangle.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
			|> Enum.map(fn line -> String.split(line, " ") end) |> Enum.map(fn line -> Enum.map(line, fn num -> String.to_integer(num) end) end)
		results = for x <- 0..(length(grid) - 1), y <- 0..(length(grid) - 1), x <= y, do: find_cell_sum({grid, x, y})
		Enum.max(results)
	end
	
	def find_cell_sum_unmem(t) do
		grid = elem(t, 0)
		x = elem(t, 1)
		y = elem(t, 2)
		v = Enum.at(Enum.at(grid, y), x)
		cond do
			x == 0 and y == 0 -> v
			x == 0 -> v + find_cell_sum({grid, x, y - 1})
			x == y -> v + find_cell_sum({grid, x - 1, y - 1})
			true -> v + Enum.max([find_cell_sum({grid, x, y - 1}), find_cell_sum({grid, x - 1, y - 1})])
		end
	end
	
	def find_cell_sum(t) do
		Memoize.memoize_func(&find_cell_sum_unmem/1).(t)
	end
end

IO.puts(Euler0067.find_pyramid_sum())