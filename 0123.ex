# Solution to https://projecteuler.net/problem=123

Code.require_file("primes.ex")

defmodule Euler0123 do
	def find_prime_square_remainder(p \\ 2, n \\ 1, target \\ 10**10) do
		cond do
			!Primes.prime?(p) -> find_prime_square_remainder(p + 1, n, target)
			rem(n, 2) == 0 -> find_prime_square_remainder(p + 1, n + 1, target)
			true -> 
				r = rem((p - 1)**n + (p + 1)**n, p**2)
				if r <= target do
					find_prime_square_remainder(p + 1, n + 1, target)
				else
					n
				end
		end
	end
end

IO.puts(Euler0123.find_prime_square_remainder())