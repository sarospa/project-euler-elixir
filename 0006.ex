# Solution to https://projecteuler.net/problem=6

defmodule Euler0006 do
	IO.puts(Enum.sum(for n <- 1..100, do: n)**2 - Enum.sum(for n <- 1..100, do: n * n))
end