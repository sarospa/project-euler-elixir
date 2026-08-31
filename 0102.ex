# Solution to https://projecteuler.net/problem=102

defmodule Euler0102 do
	@triangles File.read!("0102_triangles.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
		|> Enum.map(fn line -> String.split(line, ",") |> Enum.map(fn point -> String.to_integer(point) end) end)
	
	def triangles() do
		@triangles
	end
	
	def x_crossing(x1, y1, x2, y2) do
		cond do
			x1 == 0 -> y1
			x2 == 0 -> y2
			(y1 > 0) == (y2 > 0) -> nil
			true ->
				y_dist = abs(y1 - y2)
				x_dist = abs(x1 - x2)
				ratio = abs(y1) / y_dist
				x_part = x_dist * ratio
				if x1 > x2 do x1 - x_part else x1 + x_part end
		end
	end
	
	def contains_origin?(x1, y1, x2, y2, x3, y3) do
		[x_crossing(x1, y1, x2, y2), x_crossing(x2, y2, x3, y3), x_crossing(x3, y3, x1, y1)] |> Enum.filter(fn n -> n != nil end)
			|> then(&(Enum.any?(&1, fn n -> n > 0 end) and Enum.any?(&1, fn n -> n < 0 end)))
	end
	
	def count_containing_triangles() do
		(for [x1, y1, x2, y2, x3, y3] <- @triangles, contains_origin?(x1, y1, x2, y2, x3, y3), do: true) |> length()
	end
end

IO.puts(Euler0102.count_containing_triangles())