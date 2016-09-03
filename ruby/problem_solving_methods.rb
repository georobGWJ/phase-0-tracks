# DBC Challenge 5.6

# Release 0 - Impmement a Simple Search
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

arr = [42, 89, 23, 1]
p search_array(arr, 1)

p search_array(arr, 24)

# Release 1 - Fibonacci Numbers
