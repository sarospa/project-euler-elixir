# Solution to https://projecteuler.net/problem=12

defmodule Euler0012 do

	def countFactors(n) do
		(1..((n **0.5) |> trunc()))
			|> Enum.map(fn x -> cond do
						rem(n, x) != 0 -> 0
						x * x == n -> 1
						true -> 2
					end
				end) |> Enum.sum()
	end
	
	def findDivisibleTriangle(n, delta) do
		cond do
			countFactors(n) > 500 -> n
			true -> findDivisibleTriangle(n + delta + 1, delta + 1)
		end
	end
end

IO.puts(Euler0012.findDivisibleTriangle(1, 1))