# Solution to https://projecteuler.net/problem=121

defmodule Euler0121 do
	def calc_chance(count, prev_chances, turn) do
		cond do
			count == 0 -> {elem(prev_chances[0], 0) * turn, elem(prev_chances[0], 1) * (turn + 1)}
			count == turn -> {elem(prev_chances[turn - 1], 0), elem(prev_chances[count - 1], 1) * (turn + 1)}
			true -> {elem(prev_chances[count], 0) * turn + elem(prev_chances[count - 1], 0), elem(prev_chances[count], 1) * (turn + 1)}
		end
	end

	def next_turn(chances, turn) do
		for n <- 0..turn, into: %{}, do: {n, calc_chance(n, chances, turn)}
	end
	
	def calc_winning_chance(turns \\ 15) do
		chances = List.foldl((for n <- 2..turns, do: n), %{0 => {1, 2}, 1 => {1, 2}}, fn turn, acc -> next_turn(acc, turn) end)
		denom = elem(chances[0], 1)
		numer = (for n <- div(turns, 2) + 1..turns, do: elem(chances[n], 0)) |> Enum.sum()
		trunc(denom / numer)
	end
end

IO.puts(Euler0121.calc_winning_chance())