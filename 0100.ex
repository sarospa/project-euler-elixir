# Solution to https://projecteuler.net/problem=100

defmodule Euler0100 do
	def find_disc_ratios(n, prev \\ 1, target \\ 10**12) do
		blue = round(:math.sqrt(2) / 2 * n)
		numer = blue * (blue - 1)
		denom = n * (n - 1)
		if numer * 2 == denom do
			if n > target do
				blue
			else
				find_disc_ratios(trunc(n * (n / prev)), n)
			end
		else
			find_disc_ratios(n + 1, prev)
		end
	end
end

IO.puts(Euler0100.find_disc_ratios(2))