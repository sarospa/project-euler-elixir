# Solution to https://projecteuler.net/problem=63

defmodule Euler0063 do
	def find_powerful_digits(n \\ 1, p \\ 1, total \\ 0) do
		next_total = if (:math.log10(n ** p) |> trunc()) == p - 1 do total + 1 else total end
		cond do
			n == 9 and (:math.log10(n ** p) |> trunc()) < p - 1 -> next_total
			n == 9 -> find_powerful_digits(1, p + 1, next_total)
			true -> find_powerful_digits(n + 1, p, next_total)
		end
	end
end

IO.puts(Euler0063.find_powerful_digits())