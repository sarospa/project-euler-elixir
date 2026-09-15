# Solution to https://projecteuler.net/problem=111

Code.require_file("primes.ex")

defmodule Euler0111 do
	def find_run_primes(n, d, m, num \\ 0, count \\ 0, other_digits \\ 0) do
		cond do
			num == 0 -> (for x <- 1..9, do: find_run_primes(n, d, m, x, 1, if x == d do 0 else 1 end)) |> Enum.sum()
			count == n -> if Primes.prime?(num) do num else 0 end
			other_digits == n - m -> find_run_primes(n, d, m, num * 10 + d, count + 1, other_digits)
			count - other_digits == m -> (for x <- 0..9, x != d, do: find_run_primes(n, d, m, num * 10 + x, count + 1, other_digits + 1))
				|> Enum.sum()
			true -> (for x <- 0..9, do: find_run_primes(n, d, m, num * 10 + x, count + 1, if x == d do other_digits else other_digits + 1 end))
				|> Enum.sum()
		end
	end
	
	def find_run_primes(n, d) do
		Stream.unfold(n, fn x -> if x > 0 do {x - 1, x - 1} else nil end end) |> Stream.map(fn x -> find_run_primes(n, d, x) end)
			|> Stream.drop_while(fn x -> x == 0 end) |> Enum.take(1) |> List.first()
	end
	
	def find_run_primes(n \\ 10) do
		(for d <- 0..9, do: find_run_primes(n, d)) |> Enum.sum()
	end
end

IO.puts(Euler0111.find_run_primes())