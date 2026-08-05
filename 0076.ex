# Solution to https://projecteuler.net/problem=76

Code.require_file("memoize.ex")

defmodule Euler0076 do
	def count_sums_unmem(args) do
		n = elem(args, 0)
		bound = elem(args, 1)
		if n == 0 do
			1
		else
			(for m <- 1..bound, do: count_sums({n - m, Enum.min([m, n - m])})) |> Enum.sum()
		end
	end
	
	def count_sums(args) do
		Memoize.memoize_func(&count_sums_unmem/1).(args)
	end
end

IO.puts(Euler0076.count_sums({100, 99}))