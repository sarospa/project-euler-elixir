# Solution to https://projecteuler.net/problem=34

Code.require_file("primes.ex")

defmodule Euler0035 do
	def rotate(d, n) do
		digits = (:math.log10(d) |> trunc()) + 1
		if n == 0 do
			d
		else
			div(d, 10**n) + ((rem(d, 10**n) * 10**(digits - n)))
		end
	end
	
	def check_circular(n) do
		rot_count = :math.log10(n) |> trunc()
		(for x <- 0..rot_count, do: Primes.prime?(rotate(n, x))) |> Enum.all?()
	end
	
	def circular_primes() do
		Primes.sieve(1000000)
		(for n <- 2..999999, check_circular(n), do: n) |> length()
	end
end

IO.puts(Euler0035.circular_primes())