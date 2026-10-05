# Solution to https://projecteuler.net/problem=129

defmodule Euler0129 do
	def repunit?(n) do
		Integer.to_string(n) |> String.graphemes() |> Enum.all?(fn d -> d == "1" end)
	end
	
	def divisible_repunit(n, r \\ 0, total \\ 0) do
		digit = (for x <- 0..9, rem(x * n + r, 10) == 1, do: x) |> List.first!()
		term = n * digit + r
		if repunit?(term) do
			(Integer.to_string(term) |> String.length()) + total
		else
			divisible_repunit(n, div(term, 10), total + 1)
		end
	end
	
	def find_divisible_repunit(target \\ 10**6) do
		Stream.iterate(target, fn x -> x + 1 end) |> Stream.filter(fn x -> rem(x, 5) != 0 and rem(x, 2) != 0 end)
			|> Stream.drop_while(fn x -> divisible_repunit(x) < target end) |> Enum.take(1) |> List.first!()
	end
end

IO.puts(Euler0129.find_divisible_repunit())