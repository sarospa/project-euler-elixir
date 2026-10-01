# Solution to https://projecteuler.net/problem=128

Code.require_file("helper.ex")
Code.require_file("primes.ex")

defmodule Euler0128 do
	def hex_tile_number(n) do
		2 + Helper.triangle(n-1) * 6
	end
	
	def hex_tile_neighbors(n) do
		[hex_tile_number(n+1) - 1, hex_tile_number(n+1) + 1, hex_tile_number(n+2) - 1]
	end
	
	def off_hex_tile_neighbors(n) do
		[hex_tile_number(n-2), hex_tile_number(n-1), hex_tile_number(n+1) - 2]
	end
	
	def find_high_prime_diffs(target \\ 2000, n \\ 1, total \\ 1) do
		hex = hex_tile_number(n)
		neighbors = hex_tile_neighbors(n) |> Enum.map(fn x -> abs(hex - x) end)
		next_total = if Enum.all?(neighbors, fn x -> Primes.prime?(x) end) do total + 1 else total end
		if next_total == target do
			hex
		else
			if n >= 2 do
				off_hex = hex_tile_number(n+1) - 1
				off_neighbors = off_hex_tile_neighbors(n+1) |> Enum.map(fn x -> abs(off_hex - x) end)
				next_total = if Enum.all?(off_neighbors, fn x -> Primes.prime?(x) end) do next_total + 1 else next_total end
				if next_total == target do
					off_hex
				else
					find_high_prime_diffs(target, n+1, next_total)
				end
			else
				find_high_prime_diffs(target, n+1, next_total)
			end
		end
	end
end

IO.inspect(Euler0128.find_high_prime_diffs())