# Solution to https://projecteuler.net/problem=81

Code.require_file("memoize.ex")

defmodule Euler0081 do
	@matrix File.read!("0081_matrix.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
		|> Enum.map(fn line -> (String.split(line, ",") |> Enum.map(fn cell -> String.to_integer(cell) end)) end) |> List.foldl({%{}, 0}, fn line, acc ->
				{List.foldl(line, {elem(acc, 0), 0}, fn cell, acc_2 -> {Map.put(elem(acc_2, 0), {elem(acc_2, 1), elem(acc, 1)}, cell), elem(acc_2, 1) + 1} end) |> elem(0), elem(acc, 1) + 1}
			end) |> elem(0)

	def calc_min_path_unmem(coords) do
		x = elem(coords, 0)
		y = elem(coords, 1)
		cond do
			x == 0 and y == 0 -> @matrix[{x, y}]
			x == 0 -> @matrix[{x, y}] + calc_min_path({x, y - 1})
			y == 0 -> @matrix[{x, y}] + calc_min_path({x - 1, y})
			true -> @matrix[{x, y}] + Enum.min([calc_min_path({x, y - 1}), calc_min_path({x - 1, y})])
		end
	end
	
	def calc_min_path(coords) do
		Memoize.memoize_func(&calc_min_path_unmem/1).(coords)
	end
	
	def calc_min_path() do
		calc_min_path(Map.keys(@matrix) |> Enum.max())
	end
end

IO.puts(Euler0081.calc_min_path())