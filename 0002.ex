# Solution to https://projecteuler.net/problem=2

defmodule Euler0002 do
	def fibonacci(n) when n > 2 do
		fibonacci(n - 1) + fibonacci(n - 2)
	end
	
	def fibonacci(2) do
		2
	end
	
	def fibonacci(1) do
		1
	end
		
	def solve(n, total) do
		fib = fibonacci(n)
		if fib < 4000000 do
			total = total + (if rem(fib, 2) == 0 do fib else 0 end)
			solve(n + 1, total)
		else
			total
		end
	end
end

IO.puts(Euler0002.solve(1, 0))