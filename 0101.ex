# Solution to https://projecteuler.net/problem=101

defmodule Euler0101 do
	def reduce_difference(nums) do
		if length(nums) == 1 do
			List.first!(nums)
		else
			result = List.foldl(nums, nil, fn n, acc -> if acc == nil do {[], n} else {[n - elem(acc, 1) | elem(acc, 0)], n} end end) |> elem(0)
			if length(result) == 1 do
				List.first!(result)
			else
				reduce_difference(Enum.reverse(result))
			end
		end
	end
	
	def find_coefficient(nums, exp) do
		diff = reduce_difference(nums)
		count = reduce_difference(for n <- 1..length(nums), do: n**exp)
		div(diff, count)
	end
	
	def find_coefficients(nums) do
		exp = length(nums) - 1
		term = find_coefficient(nums, exp)
		if length(nums) > 1 do
			next_nums = Enum.take(nums, length(nums) - 1) |> Enum.with_index(1) |> Enum.map(fn n -> elem(n, 0) - term * elem(n, 1) ** exp end)
			find_coefficients(next_nums) ++ [term]
		else
			[term]
		end
	end
	
	def find_incorrect_term(nums) do
		terms = find_coefficients(nums)
		n = length(nums) + 1
		Enum.with_index(terms) |> Enum.map(fn term -> elem(term, 0) * n ** elem(term, 1) end) |> Enum.sum()
	end
	
	def sum_incorrect_terms() do
		terms = for n <- 1..10, do: 1 - n + n**2 - n**3 + n**4 - n**5 + n**6 - n**7 + n**8 - n**9 + n**10
		(for k <- 1..10, do: find_incorrect_term(Enum.take(terms, k))) |> Enum.sum()
	end
end

IO.inspect(Euler0101.sum_incorrect_terms())