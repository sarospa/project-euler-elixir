# Solution to https://projecteuler.net/problem=122

defmodule Euler0122 do
	def find_min_exponent(target, terms \\ [1], next_term \\ 1, total \\ 0, best \\ 10**10) do
		cond do
			total > best -> nil
			next_term == target -> length(terms) - 1
			true -> 
				candidates = Enum.drop_while(terms, fn n -> n + next_term > target end)
				List.foldl(candidates, best, fn n, acc ->
						result = find_min_exponent(target, [next_term + n | terms], next_term + n, total + 1, acc)
						if result != nil and result < best do result else acc end
					end)
		end
			
	end
	
	def find_min_exponents() do
		(for n <- 1..200, do: find_min_exponent(n)) |> Enum.sum()
	end
end

IO.puts(Euler0122.find_min_exponents())