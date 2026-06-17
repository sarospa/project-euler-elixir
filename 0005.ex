# Solution to https://projecteuler.net/problem=5

defmodule Euler0005 do
	def prime?(1) do
		:false
	end

	def prime?(2) do
		:true
	end

	def prime?(x) do
		Enum.empty?(for y <- 2..x - 1, rem(x, y) == 0, do: y)
	end
	
	def multiplyTo(limit, prime, x) do
		if x * prime > limit do
			x
		else
			multiplyTo(limit, prime, x * prime)
		end
	end
end

n = 20
	
IO.puts(Enum.product(for x <- 2..n, Euler0005.prime?(x), do: Euler0005.multiplyTo(n, x, x)))