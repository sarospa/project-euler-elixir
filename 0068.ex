# Solution to https://projecteuler.net/problem=68

defmodule Euler0068 do
	def update_gon(values, lines, n) do
		new_values = Map.put(values, (Map.keys(values) |> Enum.max(&>=/2, fn -> -1 end)) + 1, n)
		unique_sums = Enum.map(lines, fn line -> 
				Enum.map(line, fn i -> Map.fetch(new_values, i) end)
			end)
		|> Enum.filter(fn line -> !Enum.any?(line, fn v -> v == :error end) end)
		|> Enum.map(fn line -> Enum.sum_by(line, fn v -> elem(v, 1) end) end)
		|> Enum.uniq() |> length()
		if unique_sums <= 1 do
			new_values
		else
			nil
		end
	end
	
	def find_magic_gon(values, lines) do
		next_key = (Map.keys(values) |> Enum.max(&>=/2, fn -> -1 end)) + 1
		if next_key == 10 do
			values
		else
			key_loc = Enum.map(lines, fn line -> Enum.find_index(line, fn v -> v == next_key end) end)
				|> Enum.filter(&(&1)) |> List.first()
			nums = if key_loc == 0 do
				for n <- 1..10, do: n
			else
				for n <- 1..9, do: n
			end
			nums = Enum.filter(nums, fn n -> !Enum.any?(values, fn v -> elem(v, 1) == n end) end)
			next_gons = (for n <- nums, do: update_gon(values, lines, n)) |> Enum.filter(&(&1))
			(for gon <- next_gons, do: find_magic_gon(gon, lines)) |> List.flatten()
		end
	end
	
	def find_magic_gon() do
		lines = [[0, 1, 2], [3, 2, 4], [5, 4, 6], [7, 6, 8], [9, 8, 1]]
		gons = find_magic_gon(%{}, lines)
		gons = for gon <- gons, do: Enum.map(lines, fn line -> Enum.map(line, fn i -> Map.fetch!(gon, i) end) end)
		gons = for gon <- gons do
			min_index = Enum.find_index(gon, fn line -> line == Enum.min_by(gon, fn minline -> List.first(minline) end) end)
			Enum.slice(gon, min_index, length(gon) - min_index) ++ Enum.slice(gon, 0, min_index)
		end
		Enum.map(gons, fn gon -> Enum.map(gon, fn line -> Enum.map(line, fn v -> Integer.to_string(v) end) |> Enum.join() end) |> Enum.join() |> String.to_integer() end) |> Enum.max()
	end
end

IO.inspect(Euler0068.find_magic_gon())