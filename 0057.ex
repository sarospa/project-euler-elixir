# Solution to https://projecteuler.net/problem=57

defmodule Euler0057 do
	def root_two_expansion_count(n \\ 1, d \\ 2, iter \\ 1, count \\ 0) do
		if iter > 1000 do
			count
		else
			next_count = if String.length(Integer.to_string(n + d)) > String.length(Integer.to_string(d)) do count + 1 else count end
			next_n = d
			next_d = 2 * d + n
			root_two_expansion_count(next_n, next_d, iter + 1, next_count)
		end
	end
end

IO.puts(Euler0057.root_two_expansion_count())