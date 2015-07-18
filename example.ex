

defmodule MyList do
  def len([]), do: 0 
  def len([_head|tail]), do: 1+len(tail)

  def map([],_func), do: []
  def map([h|t], func), do: [func.(h) | map(t,func)]
end

# Define internal function & reserve list for return result
defmodule RLE do
  def encode(list), do: _encode(list, [])
  defp _encode([], result), do: Enum.reverse(result)
  defp _encode([ a, a | tail ], result) do 
    _encode( [ {a, 2} | tail ], result )
  end
  defp _encode([ {a, n}, a | tail ], result) do 
    _encode( [ {a, n+1} | tail ], result )
  end
  defp _encode([ a | tail ], result) do 
    _encode(tail, [ a | result ])
  end
end

IO.puts MyList.len [5,4,3]

IO.puts inspect MyList.map [1,2,3,4,5], &(&1*&1)

IO.puts inspect RLE.encode([1,2,2,2,3,3,4,5])

