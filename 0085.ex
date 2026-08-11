# Solution to https://projecteuler.net/problem=85

Code.require_file("helper.ex")

defmodule Euler0085 do
	def find_grid(width \\ 1, height \\ 1, best_area \\ 0, best \\ 2000000, target \\ 2000000) do
		rectangles = Helper.triangle(width) * Helper.triangle(height)
		diff = abs(target - rectangles)
		{best_area, best} = if diff < best do
				{width * height, diff}
			else
				{best_area, best}
			end
		cond do
			rectangles > target and width == height -> best_area
			rectangles > target -> find_grid(width + 1, width + 1, best_area, best, target)
			true -> find_grid(width, height + 1, best_area, best, target)
		end
	end
end

IO.puts(Euler0085.find_grid())