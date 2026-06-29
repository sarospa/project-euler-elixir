defmodule Euler0022 do
	@letter_scores %{"A" => 1, "B" => 2, "C" => 3, "D" => 4, "E" => 5, "F" => 6,
		"G" => 7, "H" => 8, "I" => 9, "J" => 10, "K" => 11, "L" => 12, "M" => 13,
		"N" => 14, "O" => 15, "P" => 16, "Q" => 17, "R" => 18, "S" => 19, "T" => 20,
		"U" => 21, "V" => 22, "W" => 23, "X" => 24, "Y" => 25, "Z" => 26}

	def score_names() do
		File.read!("0022_names.txt") |> String.replace("\"", "") |> String.split(",") |> Enum.sort() |> Enum.with_index(1)
			|> Enum.map(fn name -> {(String.graphemes(elem(name, 0)) |> Enum.map(fn g -> @letter_scores[g] end) |> Enum.sum()), elem(name, 1)} end)
			|> Enum.map(fn name -> elem(name, 0) * elem(name, 1) end) |> Enum.sum()
	end
end

IO.puts(Euler0022.score_names())