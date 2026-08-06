# Solution to https://projecteuler.net/problem=79

defmodule Euler0079 do
	def test_passcode(code, regexes) do
		string_code = Integer.to_string(code)
		if Enum.all?(regexes, fn r -> String.match?(string_code, r) end) do
			code
		else
			test_passcode(code + 1, regexes)
		end
	end
	
	def find_shortest_passcode() do
		regexes = File.read!("0079_keylog.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
			|> Enum.map(fn line -> Regex.compile!(".*" <> String.at(line, 0) <> ".*" <> String.at(line, 1) <> ".*" <> String.at(line, 2) <> ".*") end)
		test_passcode(100, regexes)
	end
end

IO.puts(Euler0079.find_shortest_passcode())