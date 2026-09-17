# Solution to https://projecteuler.net/problem=113

defmodule Euler0113 do
	use Agent

	def count_increasing(n, d) do
		cached_value = Agent.get(__MODULE__, &(Map.get(&1, "inc") |> Map.get({n, d})))
		if cached_value != nil do
			cached_value
		else
			v = if n == 1 do
				1
			else
				((for x <- d..9//1, do: count_increasing(n - 1, x)) |> Enum.sum()) + 1
			end
			Agent.update(__MODULE__, &(Map.replace(&1, "inc", Map.put(Map.get(&1, "inc"), {n, d}, v))))
			v
		end
	end
	
	def count_decreasing(n, d) do
		cached_value = Agent.get(__MODULE__, &(Map.get(&1, "dec") |> Map.get({n, d})))
		if cached_value != nil do
			cached_value
		else
			v = if n == 1 do
				1
			else
				((for x <- d..0//-1, do: count_decreasing(n - 1, x)) |> Enum.sum()) + 1
			end
			Agent.update(__MODULE__, &(Map.replace(&1, "dec", Map.put(Map.get(&1, "dec"), {n, d}, v))))
			v
		end
	end
	
	def count_increasing_decreasing(n) do
		n * 9
	end
	
	def count_non_bouncy(n \\ 100) do
		Agent.start_link(fn -> %{"inc" => %{}, "dec" => %{}} end, name: __MODULE__)
		
		decreasing = (for d <- 1..9, do: count_decreasing(n, d)) |> Enum.sum()
		increasing = (for d <- 1..9, do: count_increasing(n, d)) |> Enum.sum()
		both = count_increasing_decreasing(n)
		decreasing + increasing - both
	end
end

IO.puts(Euler0113.count_non_bouncy())