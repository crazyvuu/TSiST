def happy_number?(num=nil)
  i = 0
  while (i < 1000)
    digits = num.to_s.chars.map(&:to_i)
    num = 0
    digits.each do |digit|
      num += digit**2
    end
    return true if (num == 1)
    i += 1
    return false if (i == 999)
  end
    # return true if (sum == 1)
    # increase_depth
    # happy_number?(sum)
rescue Timeout::Error
  return false
end

def depth_value(value)
  @depth = value
end

def depth
  @depth
end

def increase_depth
  @depth += 1
end

# depth_value(0)

puts happy_number?(7)
puts happy_number?(986543210)
puts happy_number?(2)
puts happy_number?(189)