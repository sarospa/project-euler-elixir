# Solution to https://projecteuler.net/problem=76

defmodule Euler0076 do
	def count_sums(n, total, bound) do
		if total == n do
			1
		else
			(for m <- 1..bound, do: count_sums(n, total + m, Enum.min([m, n - (total + m)]))) |> Enum.sum()
		end
	end
end

IO.puts(Euler0076.count_sums(100, 0, 99))