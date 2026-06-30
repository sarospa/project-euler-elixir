# Solution to https://projecteuler.net/problem=25

defmodule Euler0025 do
	def fibonacci_index(a, b, i) do
		if b >= 10 ** 999 do
			i
		else
			fibonacci_index(b, a + b, i + 1)
		end
	end
end

IO.puts(Euler0025.fibonacci_index(1, 1, 2))