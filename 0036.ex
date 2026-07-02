# Solution to https://projecteuler.net/problem=36

defmodule Euler0036 do
	def is_palindrome(n, base) do
		Integer.to_string(n, base) == String.reverse(Integer.to_string(n, base))
	end
	
	def find_double_palindromes() do
		(for n <- 1..999999, is_palindrome(n, 10) and is_palindrome(n, 2), do: n) |> Enum.sum()
	end
end

IO.puts(Euler0036.find_double_palindromes())