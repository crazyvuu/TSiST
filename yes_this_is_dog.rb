def phone_number(phone)
  regexes = [/\d{10}$/, /\d{3}-\d{3}-\d{4}$/, /\(\d{3}\)\s{1}\d{3}-\d{4}$/, /^\d{3}-\d{4}$/]
  regexes.each do |regex|
    return true if (phone =~ regex)
  end
  return false
end

puts phone_number("(555) 555-5555")