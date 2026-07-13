# Solution to https://projecteuler.net/problem=46

Code.require_file("primes.ex")

defmodule Euler0046 do
	def check_conjecture(n) do
		(for x <- 1..trunc(n ** 0.5), 2 * (x ** 2) < n, do: Primes.prime?(n - (2 * (x ** 2)))) |> Enum.any?()
	end
	
	def find_conjecture_smallest(n) do
		if Primes.prime?(n) or check_conjecture(n) do
			find_conjecture_smallest(n + 2)
		else
			n
		end
	end
end

IO.puts(Euler0046.find_conjecture_smallest(9))