# Solution to https://projecteuler.net/problem=87

Code.require_file("primes.ex")

defmodule Euler0087 do
	def find_prime_power_sums(a \\ 2, b \\ 2, c \\ 2, target \\ 50000000, list \\ []) do
		cond do
			!Primes.prime?(a) -> find_prime_power_sums(a + 1, b, c, target, list)
			!Primes.prime?(b) -> find_prime_power_sums(a, b + 1, c, target, list)
			!Primes.prime?(c) -> find_prime_power_sums(a, b, c + 1, target, list)
			c ** 4 > target -> Enum.uniq(list) |> length()
			b ** 3 + c ** 4 > target -> find_prime_power_sums(2, 2, c + 1, target, list)
			a ** 2 + b ** 3 + c ** 4 > target -> find_prime_power_sums(2, b + 1, c, target, list)
			true -> find_prime_power_sums(a + 1, b, c, target, [a ** 2 + b ** 3 + c ** 4 | list])
		end
	end
end

IO.puts(Euler0087.find_prime_power_sums())