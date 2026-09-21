# Solution to https://projecteuler.net/problem=118

Code.require_file("primes.ex")

defmodule Euler0118 do
	def generate_pandigitals(term, digits) do
		cond do
			length(digits) == 0 and :math.log10(term) < 8 and Primes.prime?(term) -> term
			length(digits) == 0 -> []
			true ->
				values = (for n <- digits, do: generate_pandigitals(term * 10 + n, List.delete(digits, n))) |> List.flatten()
				if term > 0 and Primes.prime?(term) do
					[term | values]
				else
					values
				end
		end
	end
	
	def remove_digits(term, digits) do
		term_digits = Integer.to_string(term) |> String.graphemes() |> Enum.map(fn s -> String.to_integer(s) end)
		Enum.filter(digits, fn n -> n not in term_digits end)
	end

	def find_pandigital_primes(terms \\ MapSet.new(), digits \\ [1,2,3,4,5,6,7,8,9]) do
		if length(digits) == 0 do
			1
		else
			possible_terms = generate_pandigitals(0, digits)
			max_value = if MapSet.size(terms) == 0 do 0 else Enum.max(terms) end
			(for n <- possible_terms, n > max_value, do: find_pandigital_primes(MapSet.put(terms, n), remove_digits(n, digits))) |> Enum.sum()
		end
	end
end

IO.puts(Euler0118.find_pandigital_primes())