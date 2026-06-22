# Solution to https://projecteuler.net/problem=14

defmodule Euler0014 do
	use Agent
	
	def start do
		Agent.start_link(fn -> %{1 => 1} end, name: __MODULE__)
	end

	def collatz(n) do
		cached_value = Agent.get(__MODULE__, &(Map.get(&1, n)))
	
		if cached_value do
			cached_value
		else
			cond do
				rem(n, 2) == 0 ->
					v = 1 + collatz(trunc(n / 2))
					Agent.update(__MODULE__, &(Map.put(&1, n, v)))
					v
				true ->
					v = 1 + collatz(n * 3 + 1)
					Agent.update(__MODULE__, &(Map.put(&1, n, v)))
					v
			end
		end
	end
	
	def findCollatz(n, best_n, chain_length) do
		cond do
			n == 1000000 -> best_n
			collatz(n) > chain_length -> findCollatz(n + 1, n, collatz(n))
			true -> findCollatz(n + 1, best_n, chain_length)
		end
	end
end

Euler0014.start()
IO.puts(Euler0014.findCollatz(1, 0, 0))