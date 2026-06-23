defmodule Euler0017 do
	def ones_letter_count(n) do
		cond do
			rem(n, 10) == 0 -> 0
			rem(n, 10) == 1 -> String.length("one")
			rem(n, 10) == 2 -> String.length("two")
			rem(n, 10) == 3 -> String.length("three")
			rem(n, 10) == 4 -> String.length("four")
			rem(n, 10) == 5 -> String.length("five")
			rem(n, 10) == 6 -> String.length("six")
			rem(n, 10) == 7 -> String.length("seven")
			rem(n, 10) == 8 -> String.length("eight")
			rem(n, 10) == 9 -> String.length("nine")
		end
	end
	
	def tens_letter_count(n) do
		if rem(n, 100) > 10 and rem(n, 100) < 20 do
			cond do
				rem(n, 100) == 11 -> String.length("eleven")
				rem(n, 100) == 12 -> String.length("twelve")
				rem(n, 100) == 13 -> String.length("thirteen")
				rem(n, 100) == 14 -> String.length("fourteen")
				rem(n, 100) == 15 -> String.length("fifteen")
				rem(n, 100) == 16 -> String.length("sixteen")
				rem(n, 100) == 17 -> String.length("seventeen")
				rem(n, 100) == 18 -> String.length("eighteen")
				rem(n, 100) == 19 -> String.length("nineteen")
			end
		else
			tens = cond do
				rem(div(n, 10), 10) == 0 -> 0
				rem(div(n, 10), 10) == 1 -> String.length("ten")
				rem(div(n, 10), 10) == 2 -> String.length("twenty")
				rem(div(n, 10), 10) == 3 -> String.length("thirty")
				rem(div(n, 10), 10) == 4 -> String.length("forty")
				rem(div(n, 10), 10) == 5 -> String.length("fifty")
				rem(div(n, 10), 10) == 6 -> String.length("sixty")
				rem(div(n, 10), 10) == 7 -> String.length("seventy")
				rem(div(n, 10), 10) == 8 -> String.length("eighty")
				rem(div(n, 10), 10) == 9 -> String.length("ninety")
			end
			tens + ones_letter_count(n)
		end
	end
	
	def hundreds_letter_count(n) do
		if rem(n, 100) == 0 do
			ones_letter_count(div(n, 100)) + 7
		else
			ones_letter_count(div(n, 100)) + tens_letter_count(n) + 10
		end
	end
	
	def thousands_letter_count(n) do
		if rem(n, 1000) == 0 do
			ones_letter_count(div(n, 1000)) + 8
		else
			ones_letter_count(div(n, 1000)) + hundreds_letter_count(n) + 8
		end
	end
	
	def letter_count(n) do
		cond do
			n >= 1000 -> thousands_letter_count(n)
			n >= 100 -> hundreds_letter_count(n)
			n >= 10 -> tens_letter_count(n)
			true -> ones_letter_count(n)
		end
	end
end

IO.puts(Enum.map(1..1000, fn n -> Euler0017.letter_count(n) end) |> Enum.sum())
#IO.puts(Euler0017.letter_count(115))