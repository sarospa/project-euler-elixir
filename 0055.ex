# Solution to https://projecteuler.net/problem=55

defmodule Euler0055 do
	def palindrome?(n) do
		num = Integer.to_string(n)
		num == String.reverse(num)
	end
	
	def reverse(n) do
		Integer.to_string(n) |> String.reverse() |> String.to_integer()
	end

	def lychrel?(n, iter \\ 0) do
		if iter >= 50 do
			true
		else
			if palindrome?(n + reverse(n)) do
				false
			else
				lychrel?(n + reverse(n), iter + 1)
			end
		end
	end
	
	def count_lychrels() do
		(for n <- 1..9999, lychrel?(n), do: n) |> length()
	end
end

IO.puts(Euler0055.count_lychrels())