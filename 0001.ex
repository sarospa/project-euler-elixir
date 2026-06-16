# Solution to https://projecteuler.net/problem=1

defmodule Euler0001 do
	IO.puts(Enum.sum(for n <- 1..999, rem(n, 3) == 0 || rem(n, 5) == 0, do: n))
end