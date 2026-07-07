# Solution to https://projecteuler.net/problem=40

defmodule Euler0040 do
	def champ_constant(digit) do
		digit_info = Stream.iterate(1, &(&1 + 1))
			|> Enum.reduce_while({1, 0}, fn x, acc ->
				if elem(acc, 1) + (x * 10**(x-1) * 9) >= digit do
					{:halt, acc}
				else
					{:cont, {elem(acc, 0) + 1, elem(acc, 1) + (x * 10**(x-1) * 9)}}
				end
			end)
		offset = digit - (elem(digit_info, 1) + 1)
		number = 10**(elem(digit_info, 0)-1) + div(offset, elem(digit_info, 0))
		index = elem(digit_info, 0) - (rem(offset, elem(digit_info, 0)) + 1)
		div(number, 10**index) |> rem(10)
	end
	
	def champ_product() do
		champ_constant(1) * champ_constant(10) * champ_constant(100) * champ_constant(1000)
			* champ_constant(10000) * champ_constant(100000) * champ_constant(1000000)
	end
end

IO.puts(Euler0040.champ_product())