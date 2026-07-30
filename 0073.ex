# Solution to https://projecteuler.net/problem=73

Code.require_file("primes.ex")

defmodule Euler0073 do
	def fractions_between(lower, upper, d) do
		lower_n = elem(lower, 0)
		lower_d = elem(lower, 1)
		upper_n = elem(upper, 0)
		upper_d = elem(upper, 1)
		lower_bound = lower_n * upper_d * d
		upper_bound = upper_n * lower_d * d
		for n <- 1..d-1, n * upper_d * lower_d > lower_bound and n * upper_d * lower_d < upper_bound, do: {n, d}
	end
	
	def count_bounded_fractions() do
		(for d <- 2..12000, do: fractions_between({1, 3}, {1, 2}, d)) |> List.flatten() |> Enum.uniq_by(fn f -> elem(f, 0) / elem(f, 1) end) |> length()
	end
end

IO.puts(Euler0073.count_bounded_fractions())