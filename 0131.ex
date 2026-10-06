# Solution to https://projecteuler.net/problem=131

Code.require_file("primes.ex")

defmodule Euler0131 do
	def prime_cube_partners?(n, p) do
		value = (n**3 + n**2 * p)
		round(value ** (1/3)) ** 3 == value
	end

	#def prime_cube_partners(limit \\ 10**3) do
	#	primes = for p <- 2..limit, Primes.prime?(p), do: p
	#	for p <- primes, n <- 1..p*10, prime_cube_partners?(n, p), do: {n, p, round((n**3 + n**2 * p) ** (1/3))}
	#end
	
	def prime_cube_partners(limit \\ 10**6) do
		Stream.iterate(1, fn n -> n + 1 end) |> Stream.map(fn n -> div((n**3 + n**2)**3 - (n**3)**3, (n**3)**2) end)
			|> Enum.take_while(fn p -> p < limit end) |> Enum.filter(fn p -> Primes.prime?(p) end) |> length()
	end
end

IO.puts(Euler0131.prime_cube_partners())