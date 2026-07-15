# Solution to https://projecteuler.net/problem=56

IO.puts((for a <- 1..100, b <- 1..100, do: Integer.to_string(a ** b) |> String.graphemes() |> Enum.map(&(String.to_integer(&1))) |> Enum.sum()) |> Enum.max())