# Solution to https://projecteuler.net/problem=103

defmodule Euler0103 do
	def find_subset_sum(list, sum_list, target, sum) do
		if sum == 0 or (length(list) > 0 and sum <= Enum.max(list) * (target - length(list))) do
			nil
		else
			sum_list = if length(list) > 0 do
					MapSet.union(sum_list, (for n <- sum_list, into: MapSet.new(), do: n + List.last!(list))) |> MapSet.put(List.last!(list))
				else
					MapSet.new()
				end
			cond do
				MapSet.size(sum_list) < 2**length(list) - 1 -> nil
				length(list) + 1 == target -> 
					list = list ++ [sum]
					new_sums = for n <- sum_list, into: MapSet.new(), do: n + List.last!(list)
					sum_list = MapSet.union(sum_list, new_sums) |> MapSet.put(List.last!(list))
					tests = for n <- 2..div(length(list), 2)+1//1, do: (Enum.take(list, n) |> Enum.sum()) > (Enum.drop(list, length(list) - (n - 1)) |> Enum.sum())
					if Enum.all?(tests) and MapSet.size(sum_list) == 2**length(list) - 1 do
						Enum.map(list, fn n -> Integer.to_string(n) end) |> Enum.join()
					else
						nil
					end
				true ->
					min = if length(list) > 0 do Enum.max(list) + 1 else 20 end
					results = (for n <- min..sum//1, do: find_subset_sum(list ++ [n], sum_list, target, sum - n)) |> Enum.filter(&(&1 != nil))
					if length(results) > 0 do List.first!(results) else nil end
			end
		end
	end
	
	def find_subset_sum(target \\ 7) do
		sum = 2**target - 1
		Stream.iterate(sum, fn n -> n + 1 end) |> Stream.map(fn n -> find_subset_sum([], MapSet.new(), target, n) end)
			|> Stream.drop_while(&(&1 == nil)) |> Enum.take(1) |> List.first!()
	end
end

IO.puts(Euler0103.find_subset_sum())