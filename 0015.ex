# Solution to https://projecteuler.net/problem=15

defmodule Euler0015 do
	use Agent
	
	def start do
		Agent.start_link(fn -> %{{0, 0} => 1} end, name: __MODULE__)
	end

	def latticePaths(x, y) do
		if x < 0 or y < 0 do
			0
		else
			cached_value = Agent.get(__MODULE__, &(Map.get(&1, {x, y})))
			
			if cached_value do
				cached_value
			else
				v = latticePaths(x - 1, y) + latticePaths(x, y - 1)
				Agent.update(__MODULE__, &(Map.put(&1, {x, y}, v)))
				v
			end
		end
	end
end

Euler0015.start()
IO.puts(Euler0015.latticePaths(20, 20))