
# Comprehension
IO.puts Enum.find -50..50, &(rem(&1, 13) == 0)

# Method1: Use File.ls
{ status, dir } = File.ls(".")
if status==:ok do
  IO.puts inspect Enum.filter(dir, &File.dir?(&1))
  #IO.puts inspect Enum.filter(dir, fn(x) -> File.dir?(x)==true end )
end

# Method2: Use File.ls! and Comprehension
for list <- File.ls!("."),
    File.dir?(list) do
  IO.puts list
end

# Method3: Use PipeLine 
defmodule MyFunc do 
  def folder(path) do
    #path |> File.ls! |> Enum.filter(&File.dir?(&1))
    File.ls!(path) 
      |> Enum.filter(&File.dir?(&1))
  end
end

IO.puts inspect MyFunc.folder(".")
