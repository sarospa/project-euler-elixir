# Solution to https://projecteuler.net/problem=60

Code.require_file("primes.ex")

defmodule Euler0060 do
	def prime_pair?(x, y) do
		pair_1 = (Integer.to_string(x) <> Integer.to_string(y)) |> String.to_integer()
		pair_2 = (Integer.to_string(y) <> Integer.to_string(x)) |> String.to_integer()
		Primes.prime?(pair_1) and Primes.prime?(pair_2)
	end
	
	def find_prime_group(n \\ 3) do
		if Primes.prime?(n) do
			list = for x <- 3..(n - 1)//2, Primes.prime?(x), prime_pair?(n, x), do: x
			if length(list) >= 4 do
				group = List.foldl(list, [], fn x, acc -> 
						if (Enum.map(acc, fn y -> prime_pair?(x, y) end)) |> Enum.all?() do [x | acc]
						else acc
						end
					end)
				if length(group) >= 4 do
					Enum.sum(group) + n
				else
					find_prime_group(n + 2)
				end
			else
				find_prime_group(n + 2)
			end
		else
			find_prime_group(n + 2)
		end
	end
end

IO.puts(Euler0060.find_prime_group())