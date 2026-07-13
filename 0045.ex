# Solution to https://projecteuler.net/problem=45

defmodule Euler0045 do
	def triangle(n) do
		div((n * (n + 1)), 2)
	end
	
	def pentagon(n) do
		div((n * (3 * n - 1)), 2)
	end
	
	def hexagon(n) do
		n * (2 * n - 1)
	end
	
	def tri_pent_hex(n, m, o) do
		t = triangle(n)
		p = pentagon(m)
		h = hexagon(o)
		min = Enum.min([t, p, h])
		cond do
			t == p and t == h -> t
			t == min -> tri_pent_hex(n + 1, m, o)
			p == min -> tri_pent_hex(n, m + 1, o)
			h == min -> tri_pent_hex(n, m, o + 1)
		end
	end
end

IO.puts(Euler0045.tri_pent_hex(286, 166, 144))