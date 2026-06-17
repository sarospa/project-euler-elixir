# Solution to https://projecteuler.net/problem=9

defmodule Euler0009 do
	def findTriplet() do
		List.first!(for x <- 1..1000, y <- 1..1000, x <= y, x + y + (x * x + y * y) ** 0.5 == 1000, do: trunc(x * y * ((x * x + y * y) ** 0.5)))
	end
end

IO.puts(Euler0009.findTriplet())