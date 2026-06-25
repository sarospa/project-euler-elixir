# Solution to https://projecteuler.net/problem=19

defmodule Euler0019 do
	def days_per_month(month, year) do
		cond do
			month == 1 -> 31
			month == 2 -> if rem(year, 4) == 0 and (rem(year, 100) != 0 or rem(year, 400) == 0) do 29 else 28 end
			month == 3 -> 31
			month == 4 -> 30
			month == 5 -> 31
			month == 6 -> 30
			month == 7 -> 31
			month == 8 -> 31
			month == 9 -> 30
			month == 10 -> 31
			month == 11 -> 30
			month == 12 -> 31
		end
	end

	def count_sundays_rec(day, date, month, year, count) do
		if year > 2000 do
			count
		else
			next_count = if day == 7 and date == 1 and year > 1900 do count + 1 else count end
			next_day = if day == 7 do 1 else day + 1 end
			next_date = if date == days_per_month(month, year) do 1 else date + 1 end
			next_month = cond do
					month == 12 and date == 31 -> 1
					date == days_per_month(month, year) -> month + 1
					true -> month
				end
			next_year = if month == 12 and date == 31 do year + 1 else year end
			count_sundays_rec(next_day, next_date, next_month, next_year, next_count)
		end
	end

	def count_sundays() do
		count_sundays_rec(1, 1, 1, 1900, 0)
	end
end

IO.puts(Euler0019.count_sundays())