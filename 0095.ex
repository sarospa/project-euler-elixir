# Solution to https://projecteuler.net/problem=95

Code.require_file("primes.ex")
Code.require_file("memoize.ex")

defmodule Euler0095 do
	def divisor_sum_unmem(n) do
		Factors.proper_factors(n) |> Enum.uniq() |> Enum.sum()
	end
	
	def divisor_sum(n) do
		Memoize.memoize_func(&divisor_sum_unmem/1).(n)
	end
	
	def amicable_chain(n \\ 1, chain \\ [], target \\ 10**6, best_n \\ 0, best_chain \\ 0) do
		if length(chain) == 0 do
			amicable_chain(n, [n], target, best_n, best_chain)
		else
			next_sum = divisor_sum(List.first(chain))
			cond do
				n > target -> best_n
				next_sum > target -> amicable_chain(n + 1, [], target, best_n, best_chain)
				next_sum == n and length(chain) > best_chain -> amicable_chain(n + 1, [], target, n, length(chain))
				next_sum in chain -> amicable_chain(n + 1, [], target, best_n, best_chain)
				next_sum == n -> amicable_chain(n + 1, [], target, best_n, best_chain)
				true -> amicable_chain(n, [next_sum | chain], target, best_n, best_chain)
			end
		end
	end
end

IO.puts(Euler0095.amicable_chain())