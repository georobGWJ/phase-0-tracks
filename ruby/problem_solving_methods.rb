# DBC Challenge 5.6

# Release 0 - Impmement a Simple Search
# =====================================
def search_array(integers, target)
  idx = 0

  while idx < integers.length
    if integers[idx] == target
      return idx
    elsif idx == integers.length
      nil
    else
      idx += 1
    end
  end
end

# arr = [42, 89, 23, 1] # test code
# p search_array(arr, 1) # test code

# p search_array(arr, 24) # test code

# Release 1 - Fibonacci Numbers
# =============================
def fibonacci(num)
  fib_arr = []


  if num == 0
    fib_arr = []
    return fib_arr
  elsif num == 1
    fib_arr = [0]
    return fib_arr
  elsif num == 2
    return fib_arr = [0,1] 
  else 
    fib_arr = [0,1]
  end

  while fib_arr.length < num
    fib_arr[fib_arr.length ] = fib_arr[-1] + fib_arr[-2]
  end

  return fib_arr
end

p fibonacci(0)
p fibonacci(1)
p fibonacci(2)
p fibonacci(100) 

# def fibonacci( n )     
#   [ n ] if ( 0..1 ).include? n     
#   ( fibonacci( n - 1 ) + fibonacci( n - 2 ) ) 
#   if n > 1 
# end  

