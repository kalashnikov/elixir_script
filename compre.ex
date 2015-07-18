
IO.puts "\n## Normal ##"
# Normal 
for list <- File.ls!(".") do
  IO.puts list
end

IO.puts "\n## Filter ##"

# Filter  
for list <- File.ls!("."),
    File.dir?(list) do
  IO.puts list
end

IO.puts "\n##  Into  ##"

# Into 
for list <- File.ls!("."),
    File.dir?(list), 
    do: "#{list}",
    into: IO.stream(:stdio, :line)

IO.puts "\n\n##  Sort  ##"

# Sort 
IO.puts inspect for list <- Enum.reverse(File.ls!(".")),
    File.dir?(list),
    &String.length(&1), do: "#{list}"

IO.puts "\n#############"
