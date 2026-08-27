# Solution to https://projecteuler.net/problem=99

defmodule Euler0099 do
	@numbers File.read!("0099_base_exp.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
		|> Enum.map(fn line -> String.split(line, ",") |> Enum.map(fn s -> String.to_integer(s) end) end)
	
	def numbers() do
		@numbers
	end
	
	def estimate_power(base, exp, total \\ 1, magnitude \\ 0) do
		if exp == 0 do
			rem_magnitude = :math.log10(total) |> trunc()
			{magnitude + rem_magnitude, total / 10**rem_magnitude}
		else
			next_total = total * base
			{next_total, next_magnitude} = if next_total > 10**10 do {next_total / 10**10, magnitude + 10} else {next_total, magnitude} end
			estimate_power(base, exp - 1, next_total, next_magnitude)
		end
	end
	
	def find_largest_power() do
		Enum.with_index(@numbers, 1) |> Enum.max_by(fn {[b, e], _} -> estimate_power(b, e) end) |> elem(1)
	end
end

IO.puts(Euler0099.find_largest_power())