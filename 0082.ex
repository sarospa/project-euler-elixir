# Solution to https://projecteuler.net/problem=82

Code.require_file("memoize.ex")

defmodule Euler0082 do
	@matrix File.read!("0082_matrix.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
		|> Enum.map(fn line -> (String.split(line, ",") |> Enum.map(fn cell -> String.to_integer(cell) end)) end) |> List.foldl({%{}, 0}, fn line, acc ->
				{List.foldl(line, {elem(acc, 0), 0}, fn cell, acc_2 -> {Map.put(elem(acc_2, 0), {elem(acc_2, 1), elem(acc, 1)}, cell), elem(acc_2, 1) + 1} end) |> elem(0), elem(acc, 1) + 1}
			end) |> elem(0)

	def calc_min_path_unmem(coords) do
		x = elem(coords, 0)
		y = elem(coords, 1)
		if tuple_size(coords) == 3 do
			moving_up = elem(coords, 2)
			{_, max_y} = Map.keys(@matrix) |> Enum.max()
			cond do
				x == 0 -> @matrix[{x, y}]
				(y == max_y and moving_up) or (y == 0 and not moving_up) -> @matrix[{x, y}] + calc_min_path({x - 1, y})
				moving_up -> @matrix[{x, y}] + Enum.min([calc_min_path({x - 1, y}), calc_min_path({x, y + 1, moving_up})])
				true -> @matrix[{x, y}] + Enum.min([calc_min_path({x - 1, y}), calc_min_path({x, y - 1, moving_up})])
			end
		else
			Enum.min([calc_min_path({x, y, true}), calc_min_path({x, y, false})])
		end
	end
	
	def calc_min_path(coords) do
		Memoize.memoize_func(&calc_min_path_unmem/1).(coords)
	end
	
	def calc_min_path() do
		{x, y} = Map.keys(@matrix) |> Enum.max()
		(for n <- 0..y, do: calc_min_path({x, n})) |> Enum.min()
	end
end

IO.puts(Euler0082.calc_min_path())