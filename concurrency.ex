
## ---------------------------
## -- 並發(Concurrency)
## ---------------------------

# Elixir 依賴於 actor並發模型。在Elixir編寫並發程序的三要素：
# 創建進程，發送消息，接收消息

# 啟動一個新的進程使用`spawn`函數，接收一個函數作為參數

f = fn -> 2 * 2 end #=> #Function<erl_eval.20.80484245>
spawn(f) #=> #PID<0.40.0>


# `spawn` 函數返回一個pid(進程標識符)，你可以使用pid向進程發送消息。
# 使用 `<-` 操作符發送消息。
#  我們需要在進程內接收消息，要用到 `receive` 機制。

defmodule Geometry do
  def area_loop do
    receive do
      {:rectangle, w, h} ->
        IO.puts("Area = #{w * h}")
        area_loop()
      {:circle, r} ->
        IO.puts("Area = #{3.14 * r * r}")
        area_loop()
    end
  end
end

# 編譯這個模塊，在shell中創建一個進程，並執行 `area_looop` 函數。
pid = spawn(fn -> Geometry.area_loop() end) 
#=> #PID<0.40.0>

Process.register(pid, :kv)

# 發送一個消息給 `pid`， 會在receive語句進行模式匹配
send :kv, {:rectangle, 2, 3}
#=> Area = 6

send :kv, {:circle, 2}
#=> Area = 12.56000000000000049738

# shell也是一個進程(process), 你可以使用`self`獲取當前 pid 
#IO.puts inspect self() #=> #PID<0.27.0>

