# Solution to https://projecteuler.net/problem=94

defmodule Euler0094 do
	def count_almost_eq_triangles_a(n \\ 1, total \\ 0, target \\ 10**9) do
		n_sq = n ** 2
		m_plus = n_sq * 3 + 1
		m_minus = n_sq * 3 - 1
		a_plus = m_plus - n_sq
		c_plus = m_plus + n_sq
		a_minus = m_minus - n_sq
		c_minus = m_minus + n_sq
		plus_count = if round(:math.sqrt(m_plus)) ** 2 == m_plus and a_plus * 2 + c_plus * 2 <= target do a_plus * 2 + c_plus * 2 else 0 end
		minus_count = if round(:math.sqrt(m_minus)) ** 2 == m_minus and a_minus * 2 + c_minus * 2 <= target do a_minus * 2 + c_minus * 2 else 0 end
		if a_minus * 2 + c_minus * 2 > target do
			total
		else
			count_almost_eq_triangles_a(n + 1, total + plus_count + minus_count, target)
		end
	end
	
	def count_almost_eq_triangles_b(n \\ 1, total \\ 0, target \\ 10**9) do
		n_sq = n ** 2
		calc_plus = 16 * n_sq - 4 * n_sq + 4
		calc_minus = 16 * n_sq - 4 * n_sq - 4
		m_plus = round((-4 * n - :math.sqrt(calc_plus)) / -2)
		m_minus = round((-4 * n - :math.sqrt(calc_minus)) / -2)
		b_plus = 2 * m_plus * n
		c_plus = m_plus**2 + n_sq
		b_minus = 2 * m_minus * n
		c_minus = m_minus**2 + n_sq
		plus_count = if round(:math.sqrt(calc_plus)) ** 2 == calc_plus and b_plus * 2 + c_plus * 2 <= target do b_plus * 2 + c_plus * 2 else 0 end
		minus_count = if round(:math.sqrt(calc_minus)) ** 2 == calc_minus and b_minus * 2 + c_minus * 2 <= target do b_minus * 2 + c_minus * 2 else 0 end
		if b_minus * 2 + c_minus * 2 > target do
			total
		else
			count_almost_eq_triangles_b(n + 1, total + plus_count + minus_count, target)
		end
	end
	
	def check_almost_eq_triangle(a, c) do
		b_sq = c ** 2 - a ** 2
		b = round(:math.sqrt(b_sq))
		b ** 2 == b_sq and a * 2 + c * 2 <= 10**9 and c > a
	end
	
	def count_almost_eq_triangles() do
		count_almost_eq_triangles_a() + count_almost_eq_triangles_b()
	end
end

IO.puts(Euler0094.count_almost_eq_triangles())