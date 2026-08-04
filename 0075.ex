# Solution to https://projecteuler.net/problem=75

Code.require_file("primes.ex")

defmodule Euler0075 do
	def py_triple_perims(m, n, target) do
		a = m**2 - n**2
		b = 2 * m * n
		c = m**2 + n**2
		max_k = div(target, a + b + c)
		for k <- 1..max_k//1, do: {a * k, b * k, c * k}
	end
	
	def py_triple_perims(m, target) do
		prime_factors = Factors.find_prime_factors(m)
		(for n <- (m-1)..1//-2, !Enum.any?(prime_factors, fn p -> rem(n, p) == 0 end), do: py_triple_perims(m, n, target)) |> List.flatten()
	end
	
	def py_triple_perims(target) do
		(for m <- 2..trunc(div(target, 2)**0.5), do: py_triple_perims(m, target)) |> List.flatten() |> Enum.uniq()
			|> Enum.frequencies_by(fn t -> elem(t, 0) + elem(t, 1) + elem(t, 2) end) |> Enum.filter(fn p -> elem(p, 1) == 1 end)
			|> length()
	end
end

IO.inspect(Euler0075.py_triple_perims(1500000))