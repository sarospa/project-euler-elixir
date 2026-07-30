# Solution to https://projecteuler.net/problem=71

Code.require_file("primes.ex")

defmodule Euler0071 do
	def prev_fraction(target, d) do
		target_n = elem(target, 0)
		target_d = elem(target, 1)
		n = trunc((target_n * d) / target_d)
		{n, d}
	end

	def find_next_fraction(target \\ {3, 7}) do
		fracs = for d <- 2..10**6, rem(d, elem(target, 1)) != 0, do: prev_fraction(target, d)
		Enum.max(fracs, fn x, y -> elem(x, 0) * elem(y, 1) >= elem(y, 0) * elem(x, 1) end) |> elem(0)
	end
end

IO.puts(Euler0071.find_next_fraction())