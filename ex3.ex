defmodule Math do
  def square(x) do
    x * x
  end
end

IO.puts inspect Enum.map [1,2,3], &Math.square/1

IO.puts Enum.reduce(1..10, 2, fn (i, acc) ->
      acc * i
end)

sum=0
for input = 1..100,
    Enum.filter fn(x) -> rem(x,3)==0  or rem(x,5)==0 end,
    do 
   IO.puts 
end
