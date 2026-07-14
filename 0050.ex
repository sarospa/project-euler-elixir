# Solution to https://projecteuler.net/problem=50

Code.require_file("primes.ex")

defmodule Euler0050 do
	@target 1000000

	def find_longest_prime_sum_rec(list, start, len) do
		p = Enum.drop(list, start) |> Enum.take(len) |> Enum.sum()
		cond do
			Primes.prime?(p) and p < @target -> p
			start + len == length(list) or p > @target -> find_longest_prime_sum_rec(list, 0, len - 1)
			true -> find_longest_prime_sum_rec(list, start + 1, len)
		end
	end
	
	def find_longest_prime_sum() do
		Primes.sieve(@target)
		list = for n <- 2..@target, Primes.prime?(n), do: n
		start_len = Enum.scan(list, fn x, acc -> x + acc end) |> Enum.find_index(&(&1 >= @target))
		find_longest_prime_sum_rec(list, 0, start_len - 1)
	end
end

IO.puts(Euler0050.find_longest_prime_sum())