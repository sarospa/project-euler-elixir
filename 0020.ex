# Solution to https://projecteuler.net/problem=20

defmodule Euler0020 do
	def factorial(n) do
		if n < 2 do
			1
		else
			n * factorial(n - 1)
		end
	end
	
	def factorial_digit_sum(n) do
		factorial(n) |> Integer.to_string() |> String.graphemes() |> Enum.map(fn g -> String.to_integer(g) end) |> Enum.sum()
	end
end

IO.puts(Euler0020.factorial_digit_sum(100))