# Solution to https://projecteuler.net/problem=88

Code.require_file("primes.ex")

defmodule Euler0088 do
	def find_product_sums(values \\ [2, 2], mins \\ %{}, target \\ 12000) do
		prod = Enum.product(values)
		sum = Enum.sum(values)
		k = prod - sum + length(values)
		cond do
			k > target and Enum.all?(values, fn v -> v == 2 end) ->
				Map.values(mins) |> Enum.uniq() |> Enum.sum()
			k > target ->
				replace = Enum.count(values, fn v -> v == List.first(values) end)
				next_values = if replace == length(values) do
					for _ <- 0..replace, do: 2
				else
					(for _ <- 0..replace, do: Enum.at(values, replace) + 1) ++ Enum.drop(values, replace + 1)
				end
				find_product_sums(next_values, mins, target)
			true -> 
				next_mins = Map.put(mins, k, Enum.min([mins[k], prod]))
				find_product_sums([List.first(values) + 1 | tl(values)], next_mins, target)
		end
	end
end

IO.puts(Euler0088.find_product_sums())