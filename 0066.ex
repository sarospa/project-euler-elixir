# Solution to https://projecteuler.net/problem=66

Code.require_file("helper.ex")

defmodule Euler0066 do
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

	def continued_fraction(n, terms \\ []) do
		next_term = cond do
			length(terms) == 0 -> {trunc(n ** 0.5), 1, -trunc(n ** 0.5)}
			true -> continued_fraction_term(n, elem(List.first(terms), 1), elem(List.first(terms), 2))
		end
		if Enum.find(terms, &(&1 == next_term)) do
			terms = Enum.reverse(terms)
			start = Enum.find_index(terms, &(&1 == next_term))
			{Enum.slice(terms, 0, start), Enum.slice(terms, start, length(terms) - start)}
		else
			continued_fraction(n, [next_term | terms])
		end
	end
	
	def square_convergent(k, numer, denom, cont_fraction) do
		non_rep_len = length(elem(cont_fraction, 0))
		rep_len = length(elem(cont_fraction, 1))
		next_k = k - 1
		term = if next_k <= non_rep_len do
				Enum.at(elem(cont_fraction, 0), next_k - 1)
			else
				Enum.at(elem(cont_fraction, 1), rem(next_k - (non_rep_len + 1), rep_len))
			end
		numer = numer + elem(term, 0) * denom
		if k <= 2 do
			{numer, denom}
		else
			square_convergent(next_k, denom, numer, cont_fraction)
		end
	end
	
	def square_convergent(n, k) do
		cont_fraction = continued_fraction(n)
		non_rep_len = length(elem(cont_fraction, 0))
		rep_len = length(elem(cont_fraction, 1))
		term = if k <= non_rep_len do
				Enum.at(elem(cont_fraction, 0), k - 1)
			else
				Enum.at(elem(cont_fraction, 1), rem(k - (non_rep_len + 1), rep_len))
			end
		square_convergent(k, 1, elem(term, 0), cont_fraction)
	end

	def solve_dio(d) do
		cont_fraction = continued_fraction(d)
		period = length(elem(cont_fraction, 1))
		k = if rem(period, 2) == 0 do
				period
			else
				period * 2
			end
		{x, _} = square_convergent(d, k)
		{x, d}
	end
	
	def find_largest_minimal_x() do
		(for d <- 2..1000, trunc(d ** 0.5) != d ** 0.5, do: solve_dio(d)) |> Enum.max_by(&(elem(&1, 0))) |> elem(1)
	end
end

IO.puts(Euler0066.find_largest_minimal_x())