# Solution to https://projecteuler.net/problem=83

defmodule Euler0083 do
	@matrix File.read!("0083_matrix.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
		|> Enum.map(fn line -> (String.split(line, ",") |> Enum.map(fn cell -> String.to_integer(cell) end)) end) |> List.foldl({%{}, 0}, fn line, acc ->
				{List.foldl(line, {elem(acc, 0), 0}, fn cell, acc_2 -> {Map.put(elem(acc_2, 0), {elem(acc_2, 1), elem(acc, 1)}, cell), elem(acc_2, 1) + 1} end) |> elem(0), elem(acc, 1) + 1}
			end) |> elem(0)
	
	def dijkstra(unvisited) do
		smallest = Enum.min_by(unvisited, fn node -> elem(node, 1) end)
		{max_x, max_y} = Enum.max(Map.keys(@matrix))
		{x, y} = elem(smallest, 0)
		if x == max_x and y == max_y do
			elem(smallest, 1)
		else
			unvisited = Map.delete(unvisited, {x, y})
			distance = elem(smallest, 1)
			neighbors = [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}] |> Enum.filter(fn node -> Enum.member?(Map.keys(unvisited), node) end)
			dijkstra(List.foldl(neighbors, unvisited, fn node, acc -> Map.replace!(acc, node, Enum.min([unvisited[node], distance + @matrix[node]])) end))
		end
	end
	
	def calc_min_path() do
		unvisited = (for n <- Map.keys(@matrix), into: %{}, do: {n, 10**10}) |> Map.replace!({0, 0}, @matrix[{0, 0}])
		dijkstra(unvisited)
	end
end

IO.puts(Euler0083.calc_min_path())