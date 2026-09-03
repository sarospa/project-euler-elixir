# Solution to https://projecteuler.net/problem=112

defmodule Euler0112 do
	def increasing_number?(n) do
		(Integer.to_string(n) |> String.graphemes() |> Enum.map(fn s -> String.to_integer(s) end)
			|> List.foldl(-1, fn n, acc -> if acc == nil or n < acc do nil else n end end)) != nil
	end
	
	def decreasing_number?(n) do
		(Integer.to_string(n) |> String.graphemes() |> Enum.map(fn s -> String.to_integer(s) end)
			|> List.foldl(10, fn n, acc -> if acc == nil or n > acc do nil else n end end)) != nil
	end
	
	def bouncy_number?(n) do
		!increasing_number?(n) and !decreasing_number?(n)
	end
	
	def count_bouncy_numbers(n \\ 1, total \\ 0) do
		next_total = if bouncy_number?(n) do total + 1 else total end
		if (n - next_total) * 100 <= n do
			n
		else
			count_bouncy_numbers(n + 1, next_total)
		end
	end
end

IO.puts(Euler0112.count_bouncy_numbers())