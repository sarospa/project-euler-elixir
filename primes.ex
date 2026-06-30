Code.require_file("memoize.ex")

defmodule Primes do
	def prime_unmem(n) do
		cond do
			n < 2 -> false
			n == 2 or n == 3 -> true
			true -> !Enum.any?(for x <- 2..((n ** 0.5) |> trunc()), prime?(x), do: rem(n, x) == 0)
		end
	end
	
	def prime?(n) do
		Memoize.memoize_func(&prime_unmem/1).(n)
	end
end