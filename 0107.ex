# Solution to https://projecteuler.net/problem=107

defmodule Euler0107 do
	@network File.read!("0107_network.txt") |> String.replace("\t", "") |> String.replace("\r", "") |> String.split("\n", trim: true)
		|> Enum.map(fn line -> String.split(line, ",") |> Enum.map(fn s -> if s == "-" do nil else String.to_integer(s) end end) end)
	
	def connected?(network, nodes \\ [0]) do
		next_nodes = (List.foldl(nodes, [], fn n, acc -> ((Enum.at(network, n) |> Enum.with_index()
			|> Enum.filter(fn e -> elem(e, 0) != nil end) |> Enum.map(fn e -> elem(e, 1) end)) ++ acc) end) ++ nodes) |> Enum.uniq()
		cond do
			length(next_nodes) == length(network) -> true
			length(next_nodes) == length(nodes) -> false
			true -> connected?(network, next_nodes)
		end
	end
	
	def find_minimal_network(network \\ @network, total \\ 0) do
		node_count = length(network)
		flat_network = List.flatten(network) |> Enum.with_index()
		{value, index} = Enum.filter(flat_network, fn e -> elem(e, 0) != nil end) |> Enum.max()
		node1 = div(index, node_count)
		node2 = rem(index, node_count)
		network = List.replace_at(network, node1, List.replace_at(Enum.at(network, node1), node2, nil))
		network = List.replace_at(network, node2, List.replace_at(Enum.at(network, node2), node1, nil))
		cond do
			value == 0 -> total
			connected?(network) -> find_minimal_network(network, total + value)
			true -> 
				network = List.replace_at(network, node1, List.replace_at(Enum.at(network, node1), node2, 0))
				network = List.replace_at(network, node2, List.replace_at(Enum.at(network, node2), node1, 0))
				find_minimal_network(network, total)
		end
	end
end

IO.puts(Euler0107.find_minimal_network())