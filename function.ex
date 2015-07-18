
import String
import Enum 

defmodule Funct do
  #Functions Transform Data
  def signature1( word ) do 
    chars   = codepoints(word)
    ordered = sort(chars)
    result  = join(ordered)
    result
  end

  # Compose
  def signature2( word ) do
    join(sort(codepoints(word)))
  end

  # Pipeline
  def signature3( word ) do
    word |> codepoints |> sort |> join
  end
end

IO.puts Funct.signature3( "sbsetedsgk" )
