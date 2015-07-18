
defmodule Fib do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n-1) + fib(n-2)
  def fib_(n) do
    case n do
      0 -> 0
      1 -> 1
      n -> fib_(n-1) + fib(n-2)
    end
  end
end

defmodule PrimeFactors do
    @moduledoc """
    Inspired by Uncle Bob's algorithm:
    http://butunclebob.com/ArticleS.UncleBob.ThePrimeFactorsKata
    """
 
    @spec generate(integer) :: list
    def generate(n) do
        generate(n, [], 2) |> Enum.sort     
    end 
 
    # The inner "while" cicle
    defp generate(n, prime_factors, candidate) when rem(n, candidate) == 0 do
        generate(div(n, candidate), [candidate|prime_factors], candidate)
    end
 
    # The outer "while" cicle
    defp generate(n, prime_factors, candidate) when n > 1 do
      generate(n, prime_factors, candidate + 1)
    end
 
    defp generate(_n, prime_factors, _candidate), do: prime_factors
end

defmodule GCD do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

# Euler 2 
#even? = &(rem(&1, 2) == 0)
#IO.puts Enum.map(1..35, &Fib.fib(&1)) |> Stream.filter(&(&1<4_000_000)) |> Stream.filter(even?) |> Enum.sum


# Euler 3 
#IO.puts Enum.max(PrimeFactors.generate(13195)) 
IO.puts Enum.max(PrimeFactors.generate(600851475143))

#IO.puts GCD.gcd(100,75)
