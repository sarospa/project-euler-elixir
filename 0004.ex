# Solution to https://projecteuler.net/problem=4

defmodule Euler0004 do
	IO.puts(Enum.max(Enum.filter((for x <- 100..999, y <- 100..999, x >= y, do: x * y), fn(x) -> x == String.to_integer(String.reverse(Integer.to_string(x))) end)))
end