# Solution to https://projecteuler.net/problem=51

Code.require_file("primes.ex")

defmodule Euler0051 do
	def inc_template(template) do
		new_template = String.graphemes(template)
			|> List.foldr({"", true}, fn g, acc ->
			if elem(acc, 1) do
				cond do
					g == "*" -> {"0" <> elem(acc, 0), true}
					g == "9" -> {"*" <> elem(acc, 0), false}
					true -> {((String.to_integer(g) + 1) |> Integer.to_string()) <> elem(acc, 0), false}
				end
			else
				{g <> elem(acc, 0), false}
			end
		end) |> elem(0)
		if String.starts_with?(new_template, "0") do
			"1" <> new_template
		else
			new_template
		end
	end
	
	def replace_wildcard(template) do
		start = if String.starts_with?(template, "*") do 1 else 0 end
		for n <- start..9, do: (String.replace(template, "*", Integer.to_string(n)) |> String.to_integer())
	end
	
	def find_prime_group(template) do
		count = String.count(template, "*")
		if count > 0 and rem(count, 3) == 0 do
			prime_group = replace_wildcard(template) |> Enum.filter(&(Primes.prime?(&1)))
			if length(prime_group) == 8 do
				Enum.min(prime_group)
			else
				find_prime_group(inc_template(template))
			end
		else
			find_prime_group(inc_template(template))
		end
	end
end

IO.puts(Euler0051.find_prime_group("1"))