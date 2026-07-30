defmodule Primes do
	use Agent

	def prime?(n) do
		Agent.start_link(fn -> %{1 => false} end, name: __MODULE__)
	
		cached_value = Agent.get(__MODULE__, &(Map.get(&1, n)))
		if cached_value != nil do
			cached_value
		else
			result = cond do
				n < 2 -> false
				n == 2 or n == 3 -> true
				true -> !Enum.any?(for x <- 3..((n ** 0.5) |> trunc())//2, do: rem(n, x) == 0) and rem(n, 2) != 0
			end
			Agent.update(__MODULE__, &(Map.put(&1, n, result)))
			result
		end
	end
	
	def sieve(n) do
		Agent.start_link(fn -> %{} end, name: __MODULE__)
	
		for p <- 2..n do
			if Agent.get(__MODULE__, &(Map.get(&1, p))) != false do
				Agent.update(__MODULE__, &(Map.put(&1, p, true)))
				for x <- (p*2)..n//p, do: Agent.update(__MODULE__, &(Map.put(&1, x, false)))
			end
		end
	end
end

defmodule Factors do
	use Agent
	
	def factors(n) do
		Agent.start_link(fn -> %{1 => [1]} end, name: __MODULE__)
		
		cached_value = Agent.get(__MODULE__, &(Map.get(&1, n)))
		if cached_value != nil do
			cached_value
		else
			v = find_factors(n, [], 2)
			Agent.update(__MODULE__, &(Map.put(&1, n, v)))
			v
		end
	end
	
	def find_factors(n, factors, x) do
		cond do
			x > n -> factors
			x == n -> [x | factors]
			rem(n, x) != 0 -> find_factors(n, factors, x + 1)
			true -> find_factors(div(n, x), [x | factors], x)
		end
	end
	
	def find_prime_factors(n, factors \\ [], x \\ 2) do
		cond do
			x ** 2 > n -> factors
			!Primes.prime?(x) -> if x ** 2 < n do find_prime_factors(n, factors, x + 1) else factors end
			x ** 2 == n -> [x | factors]
			rem(n, x) != 0 -> find_prime_factors(n, factors, x + 1)
			Primes.prime?(div(n, x)) -> find_prime_factors(n, [div(n, x) | [x | factors]], x + 1)
			true -> find_prime_factors(n, [x | factors], x + 1)
		end
	end
	
	def gcd(n, m) do
		(for x <- 1..Enum.min([n, m]), rem(n, x) == 0 and rem(m, x) == 0, do: x) |> Enum.max()
	end
end

defmodule Totient do
	use Agent
	
	@small_primes for n <- 2..100, Primes.prime?(n), do: n

	def totient(n) do
		Agent.start_link(fn -> %{1 => 1} end, name: __MODULE__)
		
		cached_value = Agent.get(__MODULE__, &(Map.get(&1, n)))
		if cached_value == nil do
			if Primes.prime?(n) do
				n - 1
			else
				prime = Enum.find(@small_primes, fn p -> rem(n, p) == 0 end)
				t = if prime == nil do
					factors = Factors.find_prime_factors(n)
					{numer, denom} = List.foldl(factors, {1, 1}, fn x, acc -> {elem(acc, 0) * (x - 1), elem(acc, 1) * x} end)
					div(n * numer, denom)
				else
					factor = Stream.unfold(prime, fn p -> {p * prime, p * prime} end) |> Enum.find(fn p -> rem(n, p) != 0 end) |> div(prime)
					if factor == n do
						totient(div(factor, prime)) * prime
					else
						totient(factor) * totient(div(n, factor))
					end
				end
				Agent.update(__MODULE__, &(Map.put(&1, n, t)))
				t
			end
		else
			cached_value
		end		
	end
end