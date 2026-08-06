# Solution to https://projecteuler.net/problem=80

Code.require_file("helper.ex")

defmodule Euler0080 do
	def find_root_digit(n, r, pair_index, p \\ 0) do
		c = rem(n * 100 ** pair_index, 100) + r * 100
		x = (for x <- 0..9, do: x) |> Enum.filter(fn x -> x * (20 * p + x) <= c end) |> Enum.max()
		y = x * (20 * p + x)
		next_r = c - y
		next_p = p * 10 + x
		{x, next_r, pair_index + 1, next_p}
	end
	
	def find_root_digit_sum(n) do
		root = :math.sqrt(n)
		if trunc(root) == root do
			0
		else
			Stream.unfold({0, 0, 0, 0}, fn acc -> 
					result = find_root_digit(n, elem(acc, 1), elem(acc, 2), elem(acc, 3))
					{elem(result, 0), result}
				end) |> Stream.take(100) |> Enum.sum()
		end
	end
	
	def sum_root_digit_sums() do
		(for n <- 1..100, do: find_root_digit_sum(n)) |> Enum.sum()
	end
end

IO.puts(Euler0080.sum_root_digit_sums())