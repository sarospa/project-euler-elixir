# Solution to https://projecteuler.net/problem=65

defmodule Euler0065 do
	def e_term(k) do
		cond do
			k < 1 -> 0
			k == 1 -> 2
			rem(k, 3) == 0 -> div(k, 3) * 2
			true -> 1
		end
	end
	
	def e_convergent(k, numer, denom) do
		term = e_term(k - 1)
		numer = numer + term * denom
		if k <= 2 do
			{numer, denom}
		else
			e_convergent(k - 1, denom, numer)
		end
	end

	def e_convergent(k) do
		e_convergent(k, 1, e_term(k))
	end
	
	def convergent_digit_sum() do
		term = e_convergent(100)
		Integer.to_string(elem(term, 0)) |> String.graphemes() |> Enum.map(&(String.to_integer(&1))) |> Enum.sum()
	end
end

IO.inspect(Euler0065.convergent_digit_sum())