# Solution to https://projecteuler.net/problem=133

Code.require_file("primes.ex")

defmodule Euler0133 do
	def repunit?(n) do
		n in [1, 11, 111, 1111, 11111, 111111, 1111111, 11111111, 111111111, 1111111111]
	end

	def divisible_repunit(n, r \\ 0, total \\ 0) do
		digit = (for x <- 0..9, rem(x * n + r, 10) == 1, do: x) |> List.first!()
		term = n * digit + r
		if repunit?(term) do
			(Integer.to_string(term) |> String.length()) + total
		else
			divisible_repunit(n, div(term, 10), total + 1)
		end
	end
	
	def divisible_by_power?(n) do
		cond do
			n == 1 -> true
			rem(n, 2) == 0 -> divisible_by_power?(div(n, 2))
			rem(n, 5) == 0 -> divisible_by_power?(div(n, 5))
			true -> false
		end
	end
	
	def find_nonfactor_repunits(target \\ 10**5) do
		((for n <- 6..target, Primes.prime?(n), !divisible_by_power?(divisible_repunit(n)), do: n) |> Enum.sum()) + 2 + 3 + 5
	end
end

IO.puts(Euler0133.find_nonfactor_repunits())