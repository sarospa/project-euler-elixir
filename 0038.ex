# Solution to https://projecteuler.net/problem=38

defmodule Euler0038 do
	def pandigital?(n) do
		if n < 10**9 and n > 10**8 do
			digits = for x <- 0..8, do: rem(div(n, 10**x), 10)
			List.foldl(digits, 0, fn x, acc -> acc + x * 10**x end) == 9876543210
		else
			false
		end
	end
	
	def get_pandigital_multiple(n) do
		result = (for x <- 1..9, do: n * x) |> List.foldl(0, fn x, acc ->
				if acc > 10**8 do
					acc
				else
					(acc * 10**((:math.log10(x) |> trunc()) + 1)) + x
				end
			end)
		if pandigital?(result) do
			result
		else
			0
		end
	end
	
	def largest_pandigital_multiple() do
		(for n <- 1..9999, do: get_pandigital_multiple(n)) |> Enum.max()
	end
end

IO.puts(Euler0038.largest_pandigital_multiple())