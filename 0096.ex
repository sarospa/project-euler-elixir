# Solution to https://projecteuler.net/problem=96

defmodule Euler0096 do
	@sudokus File.read!("0096_sudoku.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
		|> List.foldl([], fn line, acc ->
			if String.contains?(line, "Grid") do
				acc ++ [[]]
			else
				List.replace_at(acc, -1, List.last!(acc) ++ [String.graphemes(line) |> Enum.map(fn g -> String.to_integer(g) end)]) end end)
		|> Enum.map(fn s -> List.flatten(s) |> Enum.with_index() |> Map.new(fn {v, i} -> {{rem(i, 9), div(i, 9)}, v} end) end)
	
	def get_possible_values(sudoku, cell_x, cell_y) do
		row = Map.keys(sudoku) |> Enum.filter(fn {_, y} -> y == cell_y end) |> Enum.map(fn k -> sudoku[k] end)
		column = Map.keys(sudoku) |> Enum.filter(fn {x, _} -> x == cell_x end) |> Enum.map(fn k -> sudoku[k] end)
		box = Map.keys(sudoku) |> Enum.filter(fn {x, y} -> div(x, 3) == div(cell_x, 3) and div(y, 3) == div(cell_y, 3) end) |> Enum.map(fn k -> sudoku[k] end)
		values = for v <- 1..9, v not in row and v not in column and v not in box, do: v
		{cell_x, cell_y, values}
	end
	
	def solve_sudoku(sudoku) do
		empty_cells = Enum.filter(sudoku, fn {_, v} -> v == 0 end)
		if length(empty_cells) == 0 do
			sudoku[{0, 0}] * 100 + sudoku[{1, 0}] * 10 + sudoku[{2, 0}]
		else
			possibilities = for c <- empty_cells, do: get_possible_values(sudoku, elem(c, 0) |> elem(0), elem(c, 0) |> elem(1))
			{next_x, next_y, next_vals} = Enum.min_by(possibilities, fn {_, _, vals} -> length(vals) end)
			results = for v <- next_vals, do: solve_sudoku(Map.replace(sudoku, {next_x, next_y}, v))
			Enum.find(results, nil, fn s -> s != nil end)
		end
	end
	
	def solve_sudokus() do
		(for s <- @sudokus, do: solve_sudoku(s)) |> Enum.sum()
	end
end

IO.puts(Euler0096.solve_sudokus())