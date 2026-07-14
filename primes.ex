defmodule Primes do
	use Agent

	def prime?(n) do
		Agent.start_link(fn -> %{1 => false} end, name: __MODULE__)
	
		cached_value = Agent.get(__MODULE__, &(Map.get(&1, n)))
		if cached_value != nil do
			cached_value
		else
			result = cond do
				n < 2 -> false
				n == 2 or n == 3 -> true
				true -> !Enum.any?(for x <- 2..((n ** 0.5) |> trunc()), prime?(x), do: rem(n, x) == 0)
			end
			Agent.update(__MODULE__, &(Map.put(&1, n, result)))
			result
		end
	end
	
	def sieve(n) do
		Agent.start_link(fn -> %{} end, name: __MODULE__)
	
		for p <- 2..n do
			if Agent.get(__MODULE__, &(Map.get(&1, p))) != false do
				Agent.update(__MODULE__, &(Map.put(&1, p, true)))
				for x <- (p*2)..n//p, do: Agent.update(__MODULE__, &(Map.put(&1, x, false)))
			end
		end
	end
end

defmodule Factors do
	use Agent
	
	def factors(n) do
		Agent.start_link(fn -> %{1 => [1]} end, name: __MODULE__)
		
		cached_value = Agent.get(__MODULE__, &(Map.get(&1, n)))
		if cached_value != nil do
			cached_value
		else
			v = find_factors(n, [], 2)
			Agent.update(__MODULE__, &(Map.put(&1, n, v)))
			v
		end
	end
	
	def find_factors(n, factors, x) do
		cond do
			x > n -> factors
			x == n -> [x | factors]
			rem(n, x) != 0 -> find_factors(n, factors, x + 1)
			true -> find_factors(div(n, x), [x | factors], x)
		end
	end
end