# Solution to https://projecteuler.net/problem=28

defmodule Euler0028 do
	def spiral(size) do
		layers = div(size, 2)
		elem((for n <- 1..layers, do: n * 2) |> List.foldl({1, 1}, fn n, acc -> {elem(acc, 0) + n * 4, elem(acc, 1) + elem(acc, 0) * 4 + n * 10} end), 1)
	end
end

IO.puts(Euler0028.spiral(1001))