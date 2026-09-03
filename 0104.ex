# Solution to https://projecteuler.net/problem=104

defmodule Euler0104 do
	def pandigital?(n) do
		digits = Integer.to_string(n) |> String.graphemes() |> Enum.map(fn s -> String.to_integer(s) end)
		((for x <- 1..9, x in digits, do: x) |> length()) == 9
	end
	
	def start_pandigital?(n) do
		rem(n, 10**9) |> pandigital?()
	end
	
	def truncate_to(n, digits) do
		cond do
			n < 10**digits -> n
			n >= 10**(digits*2) -> truncate_to(div(n, 10**digits), digits)
			true -> truncate_to(div(n, 10), digits)
		end
	end
	
	def end_pandigital?(n) do
		truncate_to(n, 9) |> pandigital?()
	end
	
	def find_pandigital_fibonacci(n \\ 2, fib1 \\ 1, fib2 \\ 0) do
		fib = fib1 + fib2
		if start_pandigital?(fib) and end_pandigital?(fib) do
			n
		else
			find_pandigital_fibonacci(n + 1, fib, fib1)
		end
	end
end

IO.puts(Euler0104.find_pandigital_fibonacci())