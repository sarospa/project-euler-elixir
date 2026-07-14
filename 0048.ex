# Solution to https://projecteuler.net/problem=48

IO.puts(rem((for n <- 1..1000, do: n ** n) |> Enum.sum(), 10**10))