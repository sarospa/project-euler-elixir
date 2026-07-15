# Solution to https://projecteuler.net/problem=54

defmodule Euler0054 do
	def value(hand) do
		has_flush = (Enum.uniq_by(hand, &(String.at(&1, 1))) |> length()) == 1
		values = Enum.map(hand, fn c ->
			cond do
				String.at(c, 0) == "A" -> 14
				String.at(c, 0) == "K" -> 13
				String.at(c, 0) == "Q" -> 12
				String.at(c, 0) == "J" -> 11
				String.at(c, 0) == "T" -> 10
				true -> String.to_integer(String.at(c, 0))
			end
		end) |> Enum.sort()
		value_freqs = Enum.frequencies(values)
		straight_value = if Enum.min(values) == Enum.max(values) - 4 and length(Enum.uniq(values)) == 5 do Enum.max(values) else 0 end
		pairs = Map.filter(value_freqs, fn {_key, val} -> val == 2 end) |> Map.keys()
		threes = Map.filter(value_freqs, fn {_key, val} -> val == 3 end) |> Map.keys()
		fours = Map.filter(value_freqs, fn {_key, val} -> val == 4 end) |> Map.keys()
		high_cards = Enum.at(values, 0) + Enum.at(values, 1) * 100 + Enum.at(values, 2) * 100 ** 2 + Enum.at(values, 3) * 100 ** 3 + Enum.at(values, 4) * 100 ** 4
		pair = if length(pairs) > 0 do Enum.max(pairs) * 100 ** 5 else 0 end
		two_pair = if length(pairs) > 1 do Enum.min(pairs) * 100 ** 6 + Enum.max(pairs) * 100 ** 7 else 0 end
		three_of_a_kind = if length(threes) > 0 do Enum.max(threes) * 100 ** 8 else 0 end
		straight = if straight_value > 0 do straight_value * 100 ** 9 else 0 end
		flush = if has_flush do 100 ** 10 else 0 end
		full_house = if pair > 0 and three_of_a_kind > 0 do Enum.max(pairs) * 100 ** 11 + Enum.max(threes) * 100 ** 12 else 0 end
		four_of_a_kind = if length(fours) > 0 do Enum.max(fours) * 100 ** 13 else 0 end
		straight_flush = if has_flush and straight_value > 0 do straight_value * 100 ** 14 else 0 end
		straight_flush + four_of_a_kind + full_house + flush + straight + three_of_a_kind + two_pair + pair + high_cards
	end

	def winning_hand?(player_1, player_2) do
		value(player_1) > value(player_2)
	end
	
	def count_winning_hands() do
		File.read!("0054_poker.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
			|> Enum.map(fn line -> String.split(line, " ") end) |> Enum.map(fn cards -> [Enum.slice(cards, 0..4), Enum.slice(cards, 5..9)] end)
			|> Enum.filter(fn hands -> winning_hand?(Enum.at(hands, 0), Enum.at(hands, 1)) end) |> length()
	end
end

IO.inspect(Euler0054.count_winning_hands())