# Solution to https://projecteuler.net/problem=74

defmodule Euler0074 do
	def digit_factorial(n) do
		Integer.to_string(n) |> String.graphemes() |> Enum.map(fn g -> (for x <- 0..String.to_integer(g), do: Enum.max([x, 1])) |> Enum.product() end) |> Enum.sum()
	end
	
	def factorial_chain_length(n, terms \\ [], total \\ 1) do
		next_terms = [n | terms]
		next_n = digit_factorial(n)
		if Enum.any?(next_terms, fn x -> x == next_n end) do
			total
		else
			factorial_chain_length(next_n, next_terms, total + 1)
		end
	end
	
	def find_long_chains() do
		(for n <- 1..10**6, factorial_chain_length(n) == 60, do: n) |> length()
	end
end

IO.puts(Euler0074.find_long_chains())