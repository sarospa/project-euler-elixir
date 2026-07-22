# Solution to https://projecteuler.net/problem=64

defmodule Euler0064 do
	def continued_fraction_term(n, numer, denom) do
		recip_denom = n - (denom ** 2)
		factor = (for x <- numer..1//-1, do: x) |> Enum.filter(fn x -> rem(numer, x) == 0 and rem(recip_denom, x) == 0 end) |> List.first()
		recip_denom = div(recip_denom, factor)
		recip_numer = div(numer, factor)
		next_term = trunc((recip_numer * (n ** 0.5 + (-denom))) / recip_denom)
		next_numer = recip_denom
		next_denom = (-denom) - next_term * recip_denom
		{next_term, next_numer, next_denom}
	end
	
	def count_continued_fraction(n, terms \\ []) do
		next_term = cond do
			length(terms) == 0 -> {trunc(n ** 0.5), 1, -trunc(n ** 0.5)}
			true -> continued_fraction_term(n, elem(List.first(terms), 1), elem(List.first(terms), 2))
		end
		if Enum.find(terms, &(&1 == next_term)) do
			terms = Enum.reverse(terms)
			start = Enum.find_index(terms, &(&1 == next_term))
			length(terms) - start
		else
			count_continued_fraction(n, [next_term | terms])
		end
	end
	
	def count_continued_fractions() do
		(for n <- 1..10000, trunc(n ** 0.5) != n ** 0.5, rem(count_continued_fraction(n), 2) == 1, do: n) |> length()
	end
end

IO.puts(Euler0064.count_continued_fractions())