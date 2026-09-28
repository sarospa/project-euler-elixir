# Solution to https://projecteuler.net/problem=126
# slow (~3 min)

Code.require_file("helper.ex")

defmodule Euler0126 do
	def cuboid_layer(x, y, z, layer) do
		(x*y + x*z + y*z) * 2 + (x+y+z) * 4 * (layer-1) + Helper.triangle(if layer - 2 < 0 do 0 else layer - 2 end) * 8
	end

	def count_cuboid_layers(n, x \\ 1, y \\ 1, z \\ 1, layer \\ 1, total \\ 0) do
		result = cuboid_layer(x, y, z, layer)
		next_total = if result == n do total + 1 else total end
		cond do
			result < n -> count_cuboid_layers(n, x, y, z, layer + 1, next_total)
			x == z and layer == 1 -> next_total
			y == z and layer == 1 -> count_cuboid_layers(n, x + 1, x + 1, x + 1, 1, next_total)
			layer == 1 -> count_cuboid_layers(n, x, y + 1, y + 1, 1, next_total)
			true -> count_cuboid_layers(n, x, y, z + 1, 1, next_total)
		end
	end
	
	def find_cuboid_layers(target \\ 1000) do
		Stream.iterate(2, fn n -> n + 2 end) |> Stream.map(fn n -> {count_cuboid_layers(n), n} end)
			|> Stream.drop_while(fn v -> elem(v, 0) != target end) |> Enum.take(1) |> List.first!()
			|> elem(1)
	end
end

IO.puts(Euler0126.find_cuboid_layers())