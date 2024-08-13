def merge_sort(arr)
  return arr if arr.length <= 1

  length = arr.length
  half = (length / 2).floor
  left = arr[0...half]
  right = arr[half...length]
  merge(merge_sort(left), merge_sort(right))
end

def merge(arr1, arr2)
  result = []

  until arr1.empty? && arr2.empty?
    if arr1.empty?
      result << arr2[0]
      arr2.shift
    elsif arr2.empty?
      result << arr1[0]
      arr1.shift
    elsif arr1[0] <= arr2[0]
      result << arr1[0]
      arr1.shift
    else
      result << arr2[0]
      arr2.shift
    end
  end
  result
end
