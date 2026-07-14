# Solution to https://projecteuler.net/problem=49

Code.require_file("primes.ex")

defmodule Euler0049 do
	def find_sequence_rec(term_1, diff) do
		term_2 = term_1 + diff
		term_3 = term_2 + diff
		digits_1 = [div(term_1, 10**3), div(term_1, 10**2) |> rem(10), div(term_1, 10) |> rem(10), rem(term_1, 10)] |> Enum.sort()
		digits_2 = [div(term_2, 10**3), div(term_2, 10**2) |> rem(10), div(term_2, 10) |> rem(10), rem(term_2, 10)] |> Enum.sort()
		digits_3 = [div(term_3, 10**3), div(term_3, 10**2) |> rem(10), div(term_3, 10) |> rem(10), rem(term_3, 10)] |> Enum.sort()
		cond do
			term_1 == 1487 and diff == 3330 -> find_sequence_rec(term_1 + 2, diff)
			digits_1 == digits_2 and digits_1 == digits_3 and Primes.prime?(term_1) and Primes.prime?(term_2) and Primes.prime?(term_3) -> term_3 + term_2 * 10**4 + term_1 * 10**8
			term_3 + 2 >= 10000 -> find_sequence_rec(1001, diff + 2)
			true -> find_sequence_rec(term_1 + 2, diff)
		end
	end
	
	def find_sequence() do
		Primes.sieve(10000)
		find_sequence_rec(1001, 2)
	end
end

IO.puts(Euler0049.find_sequence())