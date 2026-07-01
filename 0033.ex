# Solution to https://projecteuler.net/problem=33

defmodule Euler0033 do
	def check_digit_cancel(n_tens, n_ones, d_tens, d_ones) do
		one_to_ten = if n_tens == d_ones do
				d_tens != 0 and (n_tens * 10 + n_ones) / (d_tens * 10 + d_ones) == n_ones / d_tens
			else
				false
			end
		if n_ones == d_tens do
				d_ones != 0 and (n_tens * 10 + n_ones) / (d_tens * 10 + d_ones) == n_tens / d_ones
			else
				one_to_ten
			end
	end
	
	def reduce_fraction(f) do
		n = Enum.at(f, 0)
		d = Enum.at(f, 1)
		(for x <- n..2//-1, rem(n, x) == 0 and rem(d, x) == 0, do: [div(n, x), div(d, x)]) |> hd()
	end
	
	def digit_cancels() do
		(for n_t <- 1..9, n_o <- 0..9, d_t <- 1..9, d_o <- 0..9, (n_t * 10 + n_o) < (d_t * 10 + d_o), check_digit_cancel(n_t, n_o, d_t, d_o), do: [n_t * 10 + n_o, d_t * 10 + d_o])
			|> List.foldl([1, 1], fn f, acc -> [Enum.at(f, 0) * Enum.at(acc, 0), Enum.at(f, 1) * Enum.at(acc, 1)] end) |> reduce_fraction() |> Enum.at(1)
	end
end

IO.puts(Euler0033.digit_cancels())