# Solution to https://projecteuler.net/problem=62

Code.require_file("helper.ex")

defmodule Euler0062 do
	def find_permuted_cube(n \\ 1) do
		start = Enum.min([(10 ** (:math.log10(n ** 3) |> trunc()) ** (1/3)) |> trunc(), n - 1])
		perms = for m <- start..(n-1), Helper.permutations?(n ** 3, m ** 3), do: m ** 3
		if length(perms) >= 4 do
			Enum.min(perms)
		else
			find_permuted_cube(n + 1)
		end
	end
end

IO.puts(Euler0062.find_permuted_cube())