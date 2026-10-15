# Solution to https://projecteuler.net/problem=145

defmodule Euler0145 do
	def reverse(n) do
		Integer.to_string(n) |> String.graphemes() |> Enum.reverse() |> List.foldl("", fn g, acc -> acc <> g end) |> String.to_integer()
	end
	
	def reversible?(n) do
		rem(n, 10) != 0 and Integer.to_string(n + reverse(n)) |> String.graphemes()
			|> Enum.all?(fn g -> g in ["1", "3", "5", "7", "9"] end)
	end
	
	def rev_pairs() do
		for n <- 0..99, Integer.to_string(n + div(n, 10) + rem(n, 10)*10) |> String.graphemes() |> Enum.all?(fn g -> g in ["1", "3", "5", "7", "9"] end), do: n
	end
	
	def calc_even_digits(d) do
		inner_pairs = div(d, 2) - 1
		outer_pairs = rev_pairs() |> Enum.filter(fn n -> n >= 10 and rem(n, 10) != 0 end) |> length()
		outer_pairs * (rev_pairs() |> length())**inner_pairs
	end

	def calc_rev_numbers() do
		 hundreds = (for n <- 100..999, reversible?(n), do: n) |> length()
		 millions = (for n <- 1000000..9999999, reversible?(n), do: n) |> length()
		 hundreds + millions + calc_even_digits(2) + calc_even_digits(4) + calc_even_digits(6) + calc_even_digits(8)
	end
end

IO.inspect(Euler0145.calc_rev_numbers())