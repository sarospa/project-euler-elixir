# Solution to https://projecteuler.net/problem=78

Code.require_file("memoize.ex")
Code.require_file("helper.ex")

defmodule Euler0078 do
	def count_sums_unmem(n) do
		if n <= 1 do
			1
		else
			pents = Stream.unfold(0, fn x -> if x <= 0 do
						{(x * -1) + 1, (x * -1) + 1}
					else
						{x * -1, x * -1}
					end
				end) |> Stream.map(fn x -> Helper.pentagon(x) end)
				|> Stream.take_while(fn x -> x <= n end)
			sum_counts = for x <- pents, do: count_sums(n - x)
			signs = for x <- 0..(length(sum_counts) - 1), do: (if rem(x, 4) < 2 do 1 else -1 end)
			sum_counts = Enum.zip_with(sum_counts, signs, fn c, s -> c * s end)
			Enum.sum(sum_counts)
		end
	end
	
	def count_sums(n) do
		Memoize.memoize_func(&count_sums_unmem/1).(n)
	end
	
	def find_divisible_sums(n \\ 2) do
		sum_count = count_sums(n)
		if rem(sum_count, 10**6) == 0 do
			n
		else
			find_divisible_sums(n + 1)
		end
	end
end

IO.inspect(Euler0078.find_divisible_sums())