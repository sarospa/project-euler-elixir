# Solution to https://projecteuler.net/problem=69

Code.require_file("primes.ex")

defmodule Euler0069 do
	def find_highly_prime(n \\ 2, product \\ 1) do
		cond do
			Primes.prime?(n) and product * n > 1000000 -> product
			Primes.prime?(n) -> find_highly_prime(n + 1, product * n)
			true -> find_highly_prime(n + 1, product)
		end
	end
end

IO.puts(Euler0069.find_highly_prime())