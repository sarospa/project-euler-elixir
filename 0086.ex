# Solution to https://projecteuler.net/problem=86

defmodule Euler0086 do
	def find_cuboids(x \\ 1, y \\ 1, z \\ 1, m \\ 100, total \\ 0) do
		b = Enum.max([x, y, z])
		a = (x + y + z) - b
		c = :math.sqrt(a**2 + b**2)
		next_total = if c == trunc(c) do total + 1 else total end
		cond do
			x == m and y == m and z == m -> total
			x == m and y == m -> find_cuboids(z + 1, z + 1, z + 1, m, next_total)
			x == m -> find_cuboids(y + 1, y + 1, z, m, next_total)
			true -> find_cuboids(x + 1, y, z, m, next_total)
		end
	end
	
	def find_cuboids_limit(m \\ 101, cuboids \\ 2060, target \\ 1000000) do
		cuboids = find_cuboids(1, 1, m, m, 0) + cuboids
		if cuboids <= target do
			find_cuboids_limit(m + 1, cuboids, target)
		else
			m
		end
	end
end

IO.puts(Euler0086.find_cuboids_limit())