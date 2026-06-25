# Solution to https://projecteuler.net/problem=14

Code.require_file("memoize.ex")

defmodule Euler0014 do
	def collatz_unmem(n) do
		cond do
			n == 1 -> 1
			rem(n, 2) == 0 -> 1 + collatz(trunc(n / 2))
			true -> 1 + collatz(n * 3 + 1)
		end
	end
	
	def collatz(n) do
		Memoize.memoize_func(&collatz_unmem/1).(n)
	end
	
	def findCollatz(n, best_n, chain_length) do
		cond do
			n == 1000000 -> best_n
			collatz(n) > chain_length -> findCollatz(n + 1, n, collatz(n))
			true -> findCollatz(n + 1, best_n, chain_length)
		end
	end
end

IO.puts(Euler0014.findCollatz(1, 0, 0))