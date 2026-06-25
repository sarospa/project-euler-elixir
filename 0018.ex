# Solution to https://projecteuler.net/problem=18

Code.require_file("memoize.ex")

defmodule Euler0018 do
	@numbers """
	75
	95 64
	17 47 82
	18 35 87 10
	20 04 82 47 65
	19 01 23 75 03 34
	88 02 77 73 07 63 67
	99 65 04 28 06 16 70 92
	41 41 26 56 83 40 80 70 33
	41 48 72 33 47 32 37 16 94 29
	53 71 44 65 25 43 91 52 97 51 14
	70 11 33 28 77 73 17 78 39 68 17 57
	91 71 52 38 17 14 91 43 58 50 27 29 48
	63 66 04 68 89 53 67 30 73 16 69 87 40 31
	04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
	"""
	
	def find_pyramid_sum() do
		grid = @numbers |> String.replace("\t", "") |> String.split("\r\n", trim: true) |> Enum.map(fn line -> String.split(line, " ") end)
			|> Enum.map(fn line -> Enum.map(line, fn num -> String.to_integer(num) end) end)
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

IO.puts(Euler0018.find_pyramid_sum())