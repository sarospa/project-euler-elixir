# Solution to https://projecteuler.net/problem=89

defmodule Euler0089 do
	@numerals File.read!("0089_roman.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
	
	def roman_to_int(roman) do
		{four, roman} = if String.contains?(roman, "IV") do {4, String.replace(roman, "IV", "")} else {0, roman} end
		{nine, roman} = if String.contains?(roman, "IX") do {9, String.replace(roman, "IX", "")} else {0, roman} end
		{forty, roman} = if String.contains?(roman, "XL") do {40, String.replace(roman, "XL", "")} else {0, roman} end
		{ninety, roman} = if String.contains?(roman, "XC") do {90, String.replace(roman, "XC", "")} else {0, roman} end
		{four_hundred, roman} = if String.contains?(roman, "CD") do {400, String.replace(roman, "CD", "")} else {0, roman} end
		{nine_hundred, roman} = if String.contains?(roman, "CM") do {900, String.replace(roman, "CM", "")} else {0, roman} end
		ones = String.graphemes(roman) |> Enum.count(fn n -> n == "I" end)
		fives = (String.graphemes(roman) |> Enum.count(fn n -> n == "V" end)) * 5
		tens = (String.graphemes(roman) |> Enum.count(fn n -> n == "X" end)) * 10
		fifties = (String.graphemes(roman) |> Enum.count(fn n -> n == "L" end)) * 50
		hundreds = (String.graphemes(roman) |> Enum.count(fn n -> n == "C" end)) * 100
		five_hundreds = (String.graphemes(roman) |> Enum.count(fn n -> n == "D" end)) * 500
		thousands = (String.graphemes(roman) |> Enum.count(fn n -> n == "M" end)) * 1000
		four + nine + forty + ninety + four_hundred + nine_hundred + ones + fives + tens + fifties + hundreds + five_hundreds + thousands
	end
	
	def int_to_roman(int) do
		roman = (for _ <- 1..div(int, 1000)//1, do: "M") |> Enum.join()
		int = int - div(int, 1000) * 1000
		{roman, int} = if int >= 900 do {roman <> "CM", int - 900} else {roman, int} end
		{roman, int} = if int >= 500 do {roman <> "D", int - 500} else {roman, int} end
		{roman, int} = if int >= 400 do {roman <> "CD", int - 400} else {roman, int} end
		roman = roman <> ((for _ <- 1..div(int, 100)//1, do: "C") |> Enum.join())
		int = int - div(int, 100) * 100
		{roman, int} = if int >= 90 do {roman <> "XC", int - 90} else {roman, int} end
		{roman, int} = if int >= 50 do {roman <> "L", int - 50} else {roman, int} end
		{roman, int} = if int >= 40 do {roman <> "XL", int - 40} else {roman, int} end
		roman = roman <> ((for _ <- 1..div(int, 10)//1, do: "X") |> Enum.join())
		int = int - div(int, 10) * 10
		{roman, int} = if int >= 9 do {roman <> "IX", int - 9} else {roman, int} end
		{roman, int} = if int >= 5 do {roman <> "V", int - 5} else {roman, int} end
		{roman, int} = if int >= 4 do {roman <> "IV", int - 4} else {roman, int} end
		roman <> ((for _ <- 1..int//1, do: "I") |> Enum.join())
	end
	
	def count_roman_diffs() do
		(for n <- @numerals, do: String.length(n) - String.length(roman_to_int(n) |> int_to_roman())) |> Enum.sum()
	end
end

IO.puts(Euler0089.count_roman_diffs())