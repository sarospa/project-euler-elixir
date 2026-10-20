# Solution to https://projecteuler.net/problem=138

defmodule Euler0138 do
	def integer_triangle?(h, b) do
		sum = h**2 + div(b, 2)**2
		cond do
			rem(b, 2) != 0 -> false
			true -> round(:math.sqrt(sum))**2 == sum
		end
	end
	
	def round_odd(n) do
		round(n / 2)*2 + 1
	end
	
	def find_integer_triangles(h \\ 15, prev \\ 1, jump \\ 2, total \\ 0, count \\ 0) do
		next_jump = if jump > 0 do (jump + 2) * -1 else (jump - 2) * -1 end
		value = cond do
			integer_triangle?(h, h-1) -> round(:math.sqrt(h**2 + div(h-1, 2)**2))
			integer_triangle?(h, h+1) -> round(:math.sqrt(h**2 + div(h+1, 2)**2))
			true -> 0
		end
		cond do
			value > 0 and count == 11 -> total + value
			value > 0 -> find_integer_triangles(round_odd(h * (h / prev)), h, 2, total + value, count + 1)
			true -> find_integer_triangles(h + next_jump, prev, next_jump, total, count)
		end
	end
end

IO.puts(Euler0138.find_integer_triangles())