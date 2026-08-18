# Solution to https://projecteuler.net/problem=91

Code.require_file("primes.ex")

defmodule Euler0091 do
	def check_points(x1, y1, x_rate, y_rate, k, target) do
		x2 = x1 + y_rate * k
		y2 = y1 + x_rate * -k
		if x1 >= 0 and x1 <= target and y1 >= 0 and y1 <= target and x2 >= 0 and x2 <= target and y2 >= 0 and y2 <= target do
			if k > 0 do
				1 + check_points(x1, y1, x_rate, y_rate, k + 1, target)
			else
				1 + check_points(x1, y1, x_rate, y_rate, k - 1, target)
			end
		else
			0
		end
	end
	
	def check_point(x, y, x_rate, y_rate, target) do
		if x >= 0 and x <= target and y >= 0 and y <= target do
			check_points(x, y, x_rate, y_rate, 1, target) + check_points(x, y, x_rate, y_rate, -1, target) + check_point(x + x_rate, y + y_rate, x_rate, y_rate, target)
		else
			0
		end
	end
	
	def find_origin_triangles(target \\ 50) do
		((for x <- 1..target, y <- 1..target, Factors.gcd(x, y) == 1, do: check_point(x, y, x, y, target)) |> Enum.sum()) + target ** 2 * 3
	end
end

IO.puts(Euler0091.find_origin_triangles())