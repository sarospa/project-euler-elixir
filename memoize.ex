defmodule Memoize do
	use Agent

	def memoize_func(fun) do
		fn n ->
			Agent.start_link(fn -> %{} end, name: __MODULE__)
			
			cached_value = Agent.get(__MODULE__, &(Map.get(&1, n)))
			if cached_value != nil do
				cached_value
			else
				v = fun.(n)
				Agent.update(__MODULE__, &(Map.put(&1, n, v)))
				v
			end
		end
	end
end