# Solution to https://projecteuler.net/problem=97

defmodule Euler0097 do
	def power_two_trunc(value, power) do
		if power == 0 do
			value
		else
			power_two_trunc(rem(value * 2, 10**10), power - 1)
		end
	end
	
	def large_prime() do
		rem(power_two_trunc(1, 7830457) * 28433 + 1, 10**10)
	end
end

IO.puts(Euler0097.large_prime())