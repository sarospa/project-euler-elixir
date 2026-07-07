# Solution to https://projecteuler.net/problem=42

defmodule Euler0042 do
	@letters %{"A" => 1, "B" => 2, "C" => 3, "D" => 4, "E" => 5, "F" => 6,
		"G" => 7, "H" => 8, "I" => 9, "J" => 10, "K" => 11, "L" => 12,
		"M" => 13, "N" => 14, "O" => 15, "P" => 16, "Q" => 17, "R" => 18,
		"S" => 19, "T" => 20, "U" => 21, "V" => 22, "W" => 23, "X" => 24,
		"Y" => 25, "Z" => 26}
	
	def triangle?(n) do
		result = (((1 + 8 * n) ** 0.5) - 1) / 2
		result == trunc(result)
	end
		
	def find_triangle_words() do
		File.read!("0042_words.txt") |> String.replace("\"", "") |> String.split(",")
			|> Enum.map(fn w -> String.graphemes(w) |> Enum.map(fn g -> @letters[g] end) |> Enum.sum() end)
			|> Enum.filter(fn n -> triangle?(n) end) |> length()
	end
end

IO.puts(Euler0042.find_triangle_words())