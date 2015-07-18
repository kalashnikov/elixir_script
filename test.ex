defmodule Primes do
  def generatePrimes(limit) do
    _generatePrimes(2..limit |> Enum.take(limit), [], limit)
  end

  defp _generatePrimes(possiblePrimes, result, limit) do
    sqrtLimit = :math.sqrt(limit)
    newPrime = List.first(possiblePrimes)

    cond do
      length(possiblePrimes) < sqrtLimit ->
        Enum.concat(result, possiblePrimes)
      true ->
        filteredPossiblePrimes = _filterNonPrimes(possiblePrimes, newPrime)
        nextResult = _addPrimeToResult(result, newPrime)

        _generatePrimes(filteredPossiblePrimes, nextResult, limit)
    end
  end

  defp _addPrimeToResult(result, prime), do: List.insert_at(result, -1, prime)

  defp _filterNonPrimes(possiblePrimes, currentPrime) do
    Enum.filter(possiblePrimes, fn(elem) -> rem(elem, currentPrime) != 0 end)
  end
end

IO.puts inspect Primes.generatePrimes 2000
