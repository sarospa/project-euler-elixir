# Solution to https://projecteuler.net/problem=92

defmodule Euler0092 do
	def square_digit_sum(n) do
		Integer.to_string(n) |> String.graphemes() |> Enum.map(fn g -> String.to_integer(g) ** 2 end) |> Enum.sum()
	end
	
	def eighty_nine_chain?(n) do
		sum = square_digit_sum(n)
		cond do
			sum == 1 -> false
			sum == 89 -> true
			true -> eighty_nine_chain?(sum)
		end
	end
	
	def find_square_digit_chains() do
		(for n <- 1..9999999, eighty_nine_chain?(n), do: n) |> length()
	end
end

IO.puts(Euler0092.find_square_digit_chains())