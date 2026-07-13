# Solution to https://projecteuler.net/problem=44

defmodule Euler0044 do
	def pentagonal(n) do
		(n * (3 * n - 1)) |> div(2)
	end
	
	def pentagonal?(n) do
		n = (1 + ((24 * n) + 1) ** 0.5) / 6
		n == trunc(n)
	end
	
	def pent_sum_check(n, x) do
		k = pentagonal(x + 1)
		j = pentagonal(x)
		d = pentagonal(n)
		cond do
			d + j == k and pentagonal?(j + k) -> true
			d + j < k -> false
			true -> pent_sum_check(n, x + 1)
		end
	end
	
	def find_pent_diff(n, m) do
		k = pentagonal(m)
		j = pentagonal(n)
		cond do
			pentagonal?(k - j) and pentagonal?(k + j) -> k - j
			n + 1 < m -> find_pent_diff(n + 1, m)
			true -> find_pent_diff(1, m + 1)
		end
	end
end

IO.puts(Euler0044.find_pent_diff(1, 2))