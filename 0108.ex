# Solution to https://projecteuler.net/problem=108

Code.require_file("primes.ex")

defmodule Euler0108 do
	def solutions_for_factors(fac_list) do
		List.foldl(fac_list, 1, fn f, acc -> acc + (acc * 2 - 1) * f end)
	end
	
	def smallest_for_factors(fac_list) do
		primes = Stream.iterate(1, fn x -> x + 1 end) |> Stream.filter(fn x -> Primes.prime?(x) end) |> Enum.take(length(fac_list))
		Enum.zip_with(primes, fac_list, fn x, y -> x ** y end) |> Enum.product()
	end
	
	def find_solution(fac_list \\ [], target \\ 1000) do
		if length(fac_list) > 0 and solutions_for_factors(fac_list) > target do
			smallest_for_factors(fac_list)
		else
			next_factors = Stream.iterate(1, fn x -> x + 1 end) |> Enum.take_while(fn x -> solutions_for_factors(fac_list ++ [x]) < target and x < 10 end)
			next_factors = next_factors ++ [length(next_factors) + 1]
			(for n <- next_factors, do: find_solution(fac_list ++ [n], target)) |> Enum.min()
		end
	end
end

IO.puts(Euler0108.find_solution())