
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

defmodule GCD do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

defmodule Utility do
  def check_palindrome(n), do: to_char_list(n)==Enum.reverse(to_char_list(n))

  def allper(n) do
    permu(n,0,[]) 
      |> Stream.filter(&(Utility.check_palindrome(&1))) 
      |> Enum.at(0) 
  end

  def permu(n,i,list) when i<n do 
    permu(n,i+1,[n*i|list])
  end

  def permu(n,n,list), do: list
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

defmodule Prime do
  def isPrime(n) when n<3, do: true
  def isPrime(n) do
    n-1..2
      |> Enum.filter(&rem(n,&1)==0) 
      |> length==0
  end

  # Ref: http://primes.utm.edu/nthprime/algorithm.php
  def  allPrime(n,idx\\-1), do: primeList([],Stream.take(2..n,n-1),n,idx)
  defp removeMul(i,list),   do: Stream.filter(list,fn(x) -> rem(x,i)!=0 end)
  defp primeList(prime,list,n,idx) do
    cond do
      length(prime)==idx ->
        List.last(prime)
      List.last(Enum.to_list(Stream.take(list,1))) > :math.sqrt(n) ->
        result = Stream.take(Stream.concat(prime,list), idx)
        List.last(Enum.to_list(result))
      true -> 
        [i] = Enum.to_list(Stream.take(list,1))
        t = Stream.drop(list,1)
        primeList(prime++[i],removeMul(i,t),n,idx)
    end
  end

  def bPrime(n,max), do: primeListMax([],Stream.take(2..n,n-1),n,max)
  defp primeListMax(prime,list,n,max) do
    cond do
      List.last(Enum.to_list(Stream.take(list,1))) > :math.sqrt(n) ->
        result = Stream.concat(prime,list)
                 |> Enum.reject(fn(x)-> x>max end)
                 |> Enum.sum
      true -> 
        [i] = Enum.to_list(Stream.take(list,1))
        t = Stream.drop(list,1)
        primeListMax(prime++[i],removeMul(i,t),n,max)
    end
  end
end

#============================================================================#
#============================================================================#
#============================================================================#

# Euler 2 
#even? = &(rem(&1, 2) == 0)
#IO.puts Enum.map(1..35, &Fib.fib(&1)) |> Stream.filter(&(&1<4_000_000)) |> Stream.filter(even?) |> Enum.sum

#============================================================================#
#============================================================================#
#============================================================================#

# Euler 3 
#IO.puts Enum.max(PrimeFactors.generate(13195)) 
#IO.puts Enum.max(PrimeFactors.generate(600851475143))

#============================================================================#
#============================================================================#
#============================================================================#

# Euler 4
#999..100 |> Enum.map(&Utility.allper(&1)) |> Enum.max |> IO.puts 

#============================================================================#
#============================================================================#
#============================================================================#

# Euler 5
#minNum = 20..1 |> Enum.filter(&Prime.isPrime(&1)==true) |> Enum.reduce(1, fn(x, acc) -> x * acc end)
#IO.puts 10..1 |> Enum.filter(&rem(2520,&1)!=0) |> length==0
#IO.puts 20..1 |> Enum.filter(&rem(2*2*2*3*minNum,&1)!=0) |> length==0
#IO.puts 2*2*2*3*minNum

#============================================================================#
#============================================================================#
#============================================================================#

# Euler 6
# Formula: (3(n+1)^2*n^2-2n*(n+1)*(2n+1))/12
#IO.puts (3*101*101*100*100-200*101*201)/12

#============================================================================#
#============================================================================#
#============================================================================#

# Euler 7 
# Find the n-th Prime
#IO.puts Prime.allPrime(1_000,168)
#IO.puts Prime.allPrime(1_000_000,1680)
#IO.puts Prime.allPrime(1_000_000,10001)
#IO.puts Prime.allPrime(1_000_000,50001)

#============================================================================#
#============================================================================#
#============================================================================#

# Euler 8
data=["7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"]

defmodule Euler8 do 
  def  doMulti(list),   do: multi(list,1)
  defp multi([],acc),   do: acc
  defp multi([h|t],acc) do 
    multi(t,h*acc) 
  end
  def dropBy(t) do
    list = elem(t,0)
    val  = elem(t,1)
    Enum.drop(String.codepoints(list),val)
  end

  def process(list) do
    list 
    |> Enum.map(&String.to_integer(&1))
    |> Enum.chunk(13)
    |> Enum.map(&Euler8.doMulti(&1))
  end
end

#IO.puts Stream.take(Stream.cycle(data),13) 
#  |> Enum.to_list
#  |> Enum.with_index
#  |> Enum.map(&Euler8.dropBy(&1))
#  |> Enum.map(&Euler8.process(&1))
#  |> List.flatten
#  |> Enum.max 

#============================================================================#
#============================================================================#
#============================================================================#

defmodule Euler9 do 
  def solve(n), do: find(n,Enum.take(1..n-1,n-1))

  defp find(n,list) do
    result = Enum.reject(list,&isPyth(n,&1,1000-n-&1))
    if !Enum.empty?(result) do
      n2 = List.first(result)
      ans = n*n2*(1000-n-n2)
      IO.puts ans 
    end
  end

  def isPyth(n1,n2,n3), do: (n1*n1 + n2*n2 - n3*n3)!=0 
end

#Stream.take(1..999,999)
#  |> Enum.map(&Euler9.solve(&1))
      
#============================================================================#
#============================================================================#
#============================================================================#

# Euler 10 
# Find sum of Prime below 2_000_000 
#IO.puts Prime.bPrime(10_000_000,2_000_000)
      
#============================================================================#
#============================================================================#
#============================================================================#

defmodule Euler12 do 
  def solve(list) do 
    if length(list)>250 do
      IO.puts Enum.reduce(list,1,fn(x,acc)->x*acc end) 
    end
  end
end

# Euler 12 
#IO.puts inspect Enum.to_list(1..1000)
#  |> Stream.map(&div(&1*(&1+1),2))
      #|> Stream.map(&PrimeFactors.generate(&1))
      #|> Stream.reject(&(length(&1)<250))
      #|> Stream.map(&length(&1))
  #|> Enum.map(fn(x)-> IO.puts x end)
  #    |> Enum.to_list

  #  |> Enum.map(&Euler12.solve(&1))

  #PrimeFactors.generate() 


      
#============================================================================#
#============================================================================#
#============================================================================#

#IO.puts Integer.parse(Float.to_string(:math.pow(2,15)))
#  |> String.codepoints
#  |> Enum.map(&String.to_integer(&1))
#  |> Enum.sum


# Euler25
defmodule Euler25 do 
  def bitlen(n), do: length(String.codepoints(Integer.to_string(Fib.fib(n))))
end

IO.puts Euler25.bitlen(7)

IO.puts inspect Enum.to_list(1..20)
  |> Stream.reject(&(Euler25.bitlen(&1)<2))
  |> Enum.to_list
      
#============================================================================#
#============================================================================#
#============================================================================#
