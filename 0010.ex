# Solution to https://projecteuler.net/problem=10

defmodule Euler0010 do
	def sumPrimes(n) do
		List.foldl((for n <- 2..(n ** 0.5 |> Float.ceil() |> trunc()), do: n), (for n <- 2..n, do: n), fn x, acc -> Enum.filter(acc, fn y -> y == x or rem(y, x) != 0 end) end) |> Enum.sum()
	end
end

IO.puts(Euler0010.sumPrimes(2000000))