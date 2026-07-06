# Solution to https://projecteuler.net/problem=39

defmodule Euler0039 do
	def right_triangle?(a, b) do
		c = (a ** 2 + b ** 2) ** 0.5
		c == trunc(c)
	end
	
	def right_triangle_count() do
		(for a <- 1..1000, b <- 1..1000, a + b < 1000, right_triangle?(a, b), do: a + b + trunc((a ** 2 + b ** 2) ** 0.5))
			|> Enum.filter(fn x -> x <= 1000 end) |> Enum.frequencies() |> Enum.max_by(fn t -> elem(t, 1) end) |> elem(0)
	end
end

IO.puts(Euler0039.right_triangle_count())