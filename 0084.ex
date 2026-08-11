# Solution to https://projecteuler.net/problem=84

defmodule Euler0084 do
	def square_string(square) do
		if square < 10 do
			"0" <> Integer.to_string(square)
		else
			Integer.to_string(square)
		end
	end

	def land_on(square, chance) do
		chances = %{}
		cond do
			square == 2 or square == 17 or square == 33 ->
				chances = Map.put(chances, 0, chance/16)
				chances = Map.put(chances, 10, chance/16)
				Map.put(chances, square, chance * 14/16)
			square == 7 or square == 22 or square == 36 ->
				chances = Map.put(chances, square, chance * 6/16)
				next_r = (for r <- [5, 15, 25, 35, 45], r > square, do: r) |> Enum.min() |> rem(40)
				next_u = (for u <- [12, 28, 52], u > square, do: u) |> Enum.min() |> rem(40)
				rec_chances = for n <- [0, 10, 11, 24, 39, 5, next_r, next_r, next_u, square - 3], do: land_on(n, chance/16)
				List.foldl(rec_chances, chances, fn c, acc -> Map.merge(acc, c, fn _, v1, v2 -> v1 + v2 end) end)
			square == 30 -> Map.put(chances, 10, 1 * chance)
			true -> Map.put(chances, square, 1 * chance)
		end
	end
	
	def roll_from(square, die1, die2, sides, chance) do
		chances = %{}
		{chances, chance} = if die1 == die2 do
				{Map.put(chances, 10, chance * 1/(sides**2)), chance - (chance * 1/(sides**2))}
			else
				{chances, chance}
			end
		Map.merge(chances, land_on(rem(square + die1 + die2, 40), chance), fn _, v1, v2 -> v1 + v2 end)
	end
	
	def roll_from(square, sides, chance) do
		start = for n <- 0..39, into: %{}, do: {n, 0}
		rolls = for a <- 1..sides, b <- 1..sides, do: roll_from(square, a, b, sides, chance * 1/(sides**2))
		List.foldl(rolls, start, fn c, acc -> Map.merge(acc, c, fn _, v1, v2 -> v1 + v2 end) end)
	end
	
	def calc_board(chances \\ nil, reps \\ 1000, sides \\ 4) do
		if reps == 0 do
			Enum.sort_by(chances, fn c -> 1 - elem(c, 1) end) |> Enum.take(3) |> List.foldl("", fn s, acc -> acc <> square_string(elem(s, 0)) end)
		else
			chances = if chances == nil do
					for n <- 0..39, do: roll_from(n, sides, 1/40)
				else
					for n <- 0..39, do: roll_from(n, sides, chances[n])
				end
			chances = List.foldl(chances, %{}, fn c, acc -> Map.merge(acc, c, fn _, v1, v2 -> v1 + v2 end) end)
			calc_board(chances, reps - 1, sides)
		end
	end
end

IO.puts(Euler0084.calc_board())