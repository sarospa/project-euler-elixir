# Solution to https://projecteuler.net/problem=47

Code.require_file("primes.ex")

defmodule Euler0047 do
	def find_consecutive_factors(n, count, req) do
		if Factors.factors(n) |> Enum.dedup() |> length() == req do
			if count == req - 1 do
				n - count
			else
				find_consecutive_factors(n + 1, count + 1, req)
			end
		else
			find_consecutive_factors(n + 1, 0, req)
		end
	end
end

IO.puts(Euler0047.find_consecutive_factors(2, 0, 4))