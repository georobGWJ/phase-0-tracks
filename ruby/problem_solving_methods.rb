# DBC Challenge 5.6
# I worked with Jessica Kwen to complete Challenge 5.6
# on 2 Sep 2016.

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

# p fibonacci(0) # test code
# p fibonacci(1) # test code
# p fibonacci(2) # test code
# p fibonacci(100) # test code

# Release 2 - Sort and Array
# ===========================
def bubble_sort(arr)

  loop do
    swapping_happened = false
    
    0.upto(arr.size-2) do |idx|
      if arr[idx] > arr[idx+1]
        temp = arr[idx]
        arr[idx] = arr[idx+1]
        arr[idx+1] = temp
        swapping_happened = true
      end
    end
    break unless swapping_happened
  end
  arr 
end

# test = [5, 1, 4, 2, 8, 15, 200, 3] # test code
# p bubble_sort(test) # test code