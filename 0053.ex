# Solution to https://projecteuler.net/problem=53

defmodule Euler0053 do
	def factorial(n) do
		Enum.product(1..n)
	end
	
	def choose(n, r) do
		div(factorial(n), (factorial(r) * factorial(n - r)))
	end
	
	def find_large_choose() do
		(for n <- 1..100, r <- 1..100, n > r, choose(n, r) > 1000000, do: {n, r}) |> length()
	end
end

IO.puts(Euler0053.find_large_choose())