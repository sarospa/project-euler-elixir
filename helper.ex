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
	
	def palindrome?(n) do
		num = Integer.to_string(n)
		num == String.reverse(num)
	end
	
	def permutations?(n, m) do
		(Integer.to_string(n) |> String.graphemes() |> Enum.sort()) == (Integer.to_string(m) |> String.graphemes() |> Enum.sort())
	end
	
	def int_sqrt(n, lower, upper) do
		mid = div(lower + upper, 2)
		mid_sq = mid ** 2
		cond do
			upper == lower + 1 and mid_sq != n -> nil
			mid_sq == n -> mid
			mid_sq > n -> int_sqrt(n, lower, mid)
			mid_sq < n -> int_sqrt(n, mid, upper)
		end
	end
	
	def int_sqrt(n) do
		int_sqrt(n, 0, n)
	end
end