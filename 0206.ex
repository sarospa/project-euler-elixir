# Solution to https://projecteuler.net/problem=206

defmodule Euler0206 do
	def special_square?(n) do
		digits = Integer.to_string(n) |> String.graphemes()
		(Enum.drop_every(["x" | digits], 2) |> List.foldl("", fn g, acc -> acc <> g end)) == "1234567890"
	end
	
	def find_concealed_square(n \\ trunc(:math.sqrt(10**18))) do
		square = n**2
		last_digits = div(square, 10**15) |> rem(100)
		if rem(n, 100000) == 0 do
			IO.inspect({n, square})
		end
		cond do
			special_square?(square) -> n
			last_digits > 29 or last_digits < 19 -> find_concealed_square(n + 1000)
			true -> find_concealed_square(n + 1)
		end
	end
end

IO.puts(Euler0206.find_concealed_square())