printer = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

printer = fn n ->
  printer.(rem(n, 3), rem(n, 5), n)
  |> to_string
  |> IO.puts
end

fizzbuzz = fn ->
  1..15 |> Enum.each printer
end

fizzbuzz.()
