# Solution to https://projecteuler.net/problem=70
# slow

Code.require_file("primes.ex")
Code.require_file("helper.ex")

defmodule Euler0070 do
	
	def totient(n) do
		if Primes.prime?(n) do
			n - 1
		else
			factors = Factors.find_prime_factors(n)
			{numer, denom} = List.foldl(factors, {1, 1}, fn x, acc -> {elem(acc, 0) * (x - 1), elem(acc, 1) * x} end)
			div(n * numer, denom)
		end
	end
	
	def find_permuted_totients(factor, mult, bound, best_n, best_t) do
		next_factor = if mult == 2 or !Primes.prime?(factor) do factor - 1 else factor end
		next_mult = if mult == 2 or !Primes.prime?(factor) do trunc(bound / (factor - 1)) else mult - 1 end
		cond do
			1/(1 - 1/factor) > best_n / best_t -> best_n
			Primes.prime?(factor) and Primes.prime?(mult) -> 
				n = factor * mult
				t = totient(n)
				if Helper.permutations?(n, t) do
					if n / t < best_n / best_t do
						find_permuted_totients(next_factor, next_mult, bound, n, t)
					else
						find_permuted_totients(next_factor, next_mult, bound, best_n, best_t)
					end
				else
					find_permuted_totients(next_factor, next_mult, bound, best_n, best_t)
				end
			true -> find_permuted_totients(next_factor, next_mult, bound, best_n, best_t)
		end
	end
	
	def find_permuted_totients() do
		bound = 10**7
		start_value = trunc(bound ** 0.5)
		Primes.sieve(start_value * 10)
		find_permuted_totients(start_value, start_value, bound, bound, 1)
	end
end

IO.puts(Euler0070.find_permuted_totients())