# Solution to https://projecteuler.net/problem=59

defmodule Euler0059 do
	def decrypt_with(ciphertext, key) do
		Enum.zip_with(ciphertext, Stream.cycle(key), fn x, y -> Bitwise.bxor(x, y) end)
	end

	def decrypt() do
		ciphertext = File.read!("0059_cipher.txt") |> String.split(",") |> Enum.map(&String.to_integer/1)
		decrypts = for a <- 97..122, b <- 97..122, c <- 97..122, do: decrypt_with(ciphertext, [a, b, c])
		Enum.max_by(decrypts, fn list -> Enum.count(list, &(&1 == 32)) end) |> Enum.sum()
	end
end

IO.puts(Euler0059.decrypt())