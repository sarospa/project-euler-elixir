# Solution to https://projecteuler.net/problem=136
# slow (~3 minutes)

defmodule Euler0136 do
	def generate_b_list(a, limit) do
		Stream.unfold(a-1, fn
			nil -> nil
			0 -> {0, nil}
			x -> {x, if x > 0 do x * -1 else (x * -1) - 1 end} end) |> Enum.take_while(fn b -> a**2 - b**2 < limit end)
				|> Enum.filter(fn b -> b > -div(a, 2) end)
	end

	def find_differences(limit \\ 5 * 10**7) do
		(for a <- 2..limit//2, b <- generate_b_list(a, limit), do: a**2 - b**2)
			|> Enum.frequencies() |> Enum.filter(fn {_, f} -> f == 1 end) |> length()
	end
end

IO.puts(Euler0136.find_differences())