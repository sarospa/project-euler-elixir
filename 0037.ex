# Solution to https://projecteuler.net/problem=37

defmodule Euler0037 do
	Code.require_file("primes.ex")

	def left_truncatable?(p) do
		cond do
			p < 10 -> Primes.prime?(p)
			Primes.prime?(p) ->
				trunc_length = :math.log10(p) |> trunc()
				left_truncatable?(rem(p, 10 ** trunc_length))
			true -> false
		end
	end
	
	def right_truncatable?(p) do
		cond do
			p < 10 -> Primes.prime?(p)
			Primes.prime?(p) -> right_truncatable?(div(p, 10))
			true -> false
		end
	end

	def truncatable?(p) do
		left_truncatable?(p) and right_truncatable?(p)
	end
	
	def truncatables() do
		Primes.sieve(1000000)
		(for n <- 10..1000000, truncatable?(n), do: n) |> Enum.sum()
	end
end

IO.puts(Euler0037.truncatables())