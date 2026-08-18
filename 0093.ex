# Solution to https://projecteuler.net/problem=93

defmodule Euler0093 do
	def add(a, b) do
		{elem(a, 0) * elem(b, 1) + elem(b, 0) * elem(a, 1), elem(a, 1) * elem(b, 1)}
	end
	
	def subtract(a, b) do
		add(a, {elem(b, 0) * -1, elem(b, 1)})
	end
	
	def multiply(a, b) do
		{elem(a, 0) * elem(b, 0), elem(a, 1) * elem(b, 1)}
	end
	
	def divide(a, b) do
		multiply(a, {elem(b, 1), elem(b, 0)})
	end

	def evaluate(exp) do
		if String.contains?(exp, "/0") do
			nil
		else
			first = {String.at(exp, 0) |> String.to_integer(), 1}
			second = {String.at(exp, 2) |> String.to_integer(), 1}
			third = {String.at(exp, 4) |> String.to_integer(), 1}
			fourth = {String.at(exp, 6) |> String.to_integer(), 1}
			op1 = String.at(exp, 1)
			op2 = String.at(exp, 3)
			op3 = String.at(exp, 5)
			result = cond do
					op1 == "+" -> add(first, second)
					op1 == "-" -> subtract(first, second)
					op1 == "*" -> multiply(first, second)
					op1 == "/" -> divide(first, second)
					op1 == "|" -> subtract(second, first)
					op1 == "\\" -> divide(second, first)
				end
			result = cond do
					op2 == "+" -> add(result, third)
					op2 == "-" -> subtract(result, third)
					op2 == "*" -> multiply(result, third)
					op2 == "/" -> divide(result, third)
					op2 == "|" -> subtract(third, result)
					op2 == "\\" -> divide(third, result)
				end
			result = cond do
					op3 == "+" -> add(result, fourth)
					op3 == "-" -> subtract(result, fourth)
					op3 == "*" -> multiply(result, fourth)
					op3 == "/" -> divide(result, fourth)
					op3 == "|" -> subtract(fourth, result)
					op3 == "\\" -> divide(result, fourth)
				end
			if elem(result, 1) != 0 and rem(elem(result, 0), elem(result, 1)) == 0 do
				div(elem(result, 0), elem(result, 1))
			else
				nil
			end
		end
		
	end
	
	def check_digits(list) do
		# | means reverse order subtraction, \ means reverse order division.
		# Don't tell me it's hacky, I already know. But something like this is needed if I don't use parenthesis.
		ops = ["+", "-", "*", "/", "|", "\\"]
		(for first <- list, second <- list, third <- list, fourth <- list, op1 <- ops, op2 <- ops, op3 <- ops,
			second != first, third != first and third != second, fourth != first and fourth != second and fourth != third,
			do: evaluate(Integer.to_string(first) <> op1 <> Integer.to_string(second) <> op2 <> Integer.to_string(third) <> op3 <> Integer.to_string(fourth)))
			|> Enum.filter(&(&1 != nil and &1 > 0)) |> Enum.uniq() |> Enum.sort() |> List.foldl(0, fn x, acc -> if x == acc + 1 do x else acc end end)
	end
	
	def check_all_digits() do
		results = for a <- 0..9, b <- 0..9, c <- 0..9, d <- 0..9, a < b, b < c, c < d,
			do: {Integer.to_string(a) <> Integer.to_string(b) <> Integer.to_string(c) <> Integer.to_string(d), check_digits([a, b, c, d])}
		Enum.max_by(results, fn t -> elem(t, 1) end) |> elem(0)
	end
end

IO.puts(Euler0093.check_all_digits())