def prime_factors(num)
  factors = (2..num).reject { |n| num % n != 0 }
  primes = []
  factors.each do |f|
    f_factors = (2..f).reject { |n| f % n != 0 }
    primes << f if (f_factors.count < 2)
  end
  factors.reject { |n| !primes.include?(n) }.to_s
end

puts prime_factors(102)
puts prime_factors(896680)
puts prime_factors(42)