defmodule Helper do
	def triangle(n) do
		div((n * (n + 1)), 2)
	end
	
	def triangular?(n) do
		n = (-1 + ((8 * n) + 1) ** 0.5) / 2
		n == trunc(n)
	end
	
	def square?(n) do
		n = n ** 0.5
		n == trunc(n)
	end
	
	def pentagon(n) do
		div((n * (3 * n - 1)), 2)
	end
	
	def pentagonal?(n) do
		n = (1 + ((24 * n) + 1) ** 0.5) / 6
		n == trunc(n)
	end
	
	def hexagon(n) do
		n * (2 * n - 1)
	end
	
	def hexagonal?(n) do
		n = (1 + ((8 * n) + 1) ** 0.5) / 4
		n == trunc(n)
	end
	
	def heptagonal?(n) do
		n = (3 + ((40 * n) + 9) ** 0.5) / 10
		n == trunc(n)
	end
	
	def octagonal?(n) do
		n = (2 + ((12 * n) + 4) ** 0.5) / 6
		n == trunc(n)
	end
end