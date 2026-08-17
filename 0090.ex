# Solution to https://projecteuler.net/problem=90

defmodule Euler0090 do
	def check_dice(die1, die2) do
		one = (1 in die1 and 0 in die2) or (0 in die1 and 1 in die2)
		four = (4 in die1 and 0 in die2) or (0 in die1 and 4 in die2)
		nine = (9 in die1 and 0 in die2) or (0 in die1 and 9 in die2) or (6 in die1 and 0 in die2) or (0 in die1 and 6 in die2)
		sixteen = (1 in die1 and 6 in die2) or (6 in die1 and 1 in die2) or (1 in die1 and 9 in die2) or (9 in die1 and 1 in die2)
		twenty_five = (2 in die1 and 5 in die2) or (5 in die1 and 2 in die2)
		thirty_six = (3 in die1 and 6 in die2) or (6 in die1 and 3 in die2) or (3 in die1 and 9 in die2) or (9 in die1 and 3 in die2)
		forty_nine = (4 in die1 and 6 in die2) or (6 in die1 and 4 in die2) or (4 in die1 and 9 in die2) or (9 in die1 and 4 in die2)
		eighty_one = (1 in die1 and 8 in die2) or (8 in die1 and 1 in die2)
		one and four and nine and sixteen and twenty_five and thirty_six and forty_nine and eighty_one
	end
	
	def check_all_dice() do
		dice = for a <- 0..9, b <- 0..9, c <- 0..9, d <- 0..9, e <- 0..9, f <- 0..9, a < b, b < c, c < d, d < e, e < f, do: [a, b, c, d, e, f]
		results = for d1 <- dice, d2 <- dice, d1 < d2, check_dice(d1, d2), do: [d1, d2]
		length(results)
	end
end

IO.puts(Euler0090.check_all_dice())