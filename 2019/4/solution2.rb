require "pry"

def two_adjacent_same(number)
  number[0] == number[1] ||
  number[1] == number[2] ||
  number[2] == number[3] ||
  number[3] == number[4] ||
  number[4] == number[5]
end

def never_decrease(number)
  number[0] <= number[1] &&
  number[1] <= number[2] &&
  number[2] <= number[3] &&
  number[3] <= number[4] &&
  number[4] <= number[5]
end

def meets_criteria(number)
  number = number.split("").map(&:to_i)
  two_adjacent_same(number) && never_decrease(number)
end

count = 0

f = File.open("numbers", "w+")

(152085..670283).each do |number|
  f.puts number if meets_criteria(number.to_s)
  # count = count + 1 if meets_criteria(number.to_s)
end

puts count

# puts meets_criteria("111111") == true
# puts meets_criteria("223450") == false
# puts meets_criteria("123789") == false
