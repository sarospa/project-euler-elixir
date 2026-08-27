# Solution to https://projecteuler.net/problem=98

defmodule Euler0098 do
	@words File.read!("0098_words.txt") |> String.replace("\t", "") |> String.replace("\"", "") |> String.split(",", trim: true)
	
	def words() do
		@words
	end
	
	def anagrams?(word1, word2) do
		(String.graphemes(word1) |> Enum.sort()) == (String.graphemes(word2) |> Enum.sort())
	end
	
	def anagram_pair_value(word1, word2, number_pool, letter_pool) do
		cond do
			String.starts_with?(word1, "0") or String.starts_with?(word2, "0") or length(letter_pool) > 10 -> 0
			length(letter_pool) == 0 -> 
				number1 = String.to_integer(word1)
				number2 = String.to_integer(word2)
				root1 = :math.sqrt(number1)
				root2 = :math.sqrt(number2)
				if round(root1) **2 == number1 and round(root2) ** 2 == number2 do
					Enum.max([number1, number2])
				else
					0
				end
			true -> (for n <- number_pool, do: anagram_pair_value(String.replace(word1, List.first!(letter_pool), Integer.to_string(n)),
				String.replace(word2, List.first!(letter_pool), Integer.to_string(n)), List.delete(number_pool, n), tl(letter_pool)))
				|> Enum.max()
		end
	end
	
	def anagram_pair_value(word1, word2) do
		anagram_pair_value(word1, word2, (for n <- 0..9, do: n), String.graphemes(word1) |> Enum.uniq())
	end
	
	def find_anagram_pair_value() do
		(for word1 <- @words, word2 <- @words, word1 != word2, anagrams?(word1, word2), do: anagram_pair_value(word1, word2)) |> Enum.max()
	end
end

IO.puts(Euler0098.find_anagram_pair_value())