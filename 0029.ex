# Solution to https://projecteuler.net/problem=29

IO.puts((for a <- 2..100, b <- 2..100, do: a ** b) |> Enum.uniq() |> length())