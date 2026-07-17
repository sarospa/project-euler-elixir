# Solution to https://projecteuler.net/problem=58

Code.require_file("primes.ex")

defmodule Euler0058 do
	def spiral_corners(layers) do
		if layers == 0 do
			[1]
		else
			highest = layers * (layers + 1) * 4 + 1
			[highest - layers * 6, highest - layers * 4, highest - layers * 2]
		end
	end
	
	def count_spiral_primes_rec(layers \\ 1, total \\ 1, primes \\ 0) do
		corners = spiral_corners(layers)
		next_total = total + 4
		next_primes = primes + length(Enum.filter(corners, &(Primes.prime?(&1))))
		if next_primes * 10 < next_total do
			layers * 2 + 1
		else
			count_spiral_primes_rec(layers + 1, next_total, next_primes)
		end
	end
	
	def count_spiral_primes() do
		count_spiral_primes_rec()
	end
end

IO.puts(Euler0058.count_spiral_primes())