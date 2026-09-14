# Solution to https://projecteuler.net/problem=109

defmodule Euler0109 do
	def find_checkouts() do
		sections = (for s <- 1..20, m <- 1..3, do: {s, m}) ++ [{25, 1}, {25, 2}, {0, 0}]
		scores = for {as,am} <- sections, {bs,bm} <- sections, {cs,cm} <- sections, cm == 2, {as,am} <= {bs,bm}, as*am + bs*bm + cs*cm < 100, do: [{as,am}, {bs,bm}, {cs,cm}]
		length(scores)
	end
end

IO.puts(Euler0109.find_checkouts())