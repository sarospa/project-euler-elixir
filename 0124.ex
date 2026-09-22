# Solution to https://projecteuler.net/problem=124

defmodule Euler0124 do
	def find_radicals(n, rads, target) do
		cond do
			n > target -> rads
			true -> 
				factors = for x <- n..target//n, into: %{}, do: {x, n}
				next_rads = Map.merge(rads, factors, fn _, a, b -> a * b end)
				keys = Map.keys(next_rads)
				next_n = Stream.iterate(n, fn x -> x + 1 end) |> Stream.drop_while(fn x -> x in keys end) |> Enum.take(1) |> List.first!()
				find_radicals(next_n, next_rads, target)
		end
	end
	
	def find_radical_index(i \\ 10000, target \\ 100000) do
		rads = find_radicals(2, %{1 => 1}, target) |> Enum.sort_by(fn {n, r} -> {r, n} end)
		Enum.at(rads, i - 1) |> elem(0)
	end
end

IO.puts(Euler0124.find_radical_index())