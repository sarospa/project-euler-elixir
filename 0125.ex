# Solution to https://projecteuler.net/problem=125

Code.require_file("helper.ex")

defmodule Euler0125 do
	def square_sum(min, max) do
		(for n <- min..max//1, do: n**2) |> Enum.sum()
	end
	
	def find_square_sums(min, max, sums, target) do
		sum = square_sum(min, max)
		cond do
			sum >= target and max == min + 1 -> sums
			sum >= target -> find_square_sums(min + 1, min + 2, sums, target)
			true -> find_square_sums(min, max + 1, [sum | sums], target)
		end
	end
	
	def find_palindrome_sums(target \\ 10**8) do
		find_square_sums(1, 2, [], target) |> Enum.filter(fn x -> Helper.palindrome?(x) end) |> Enum.uniq() |> Enum.sum()
	end
end

IO.inspect(Euler0125.find_palindrome_sums())