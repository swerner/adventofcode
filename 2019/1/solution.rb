def required_fuel(mass)
  mass / 3 - 2
end

input = File.open("input.txt").read.split("\n")

start = 0

input.each do |item|
  start = start + required_fuel(item.to_i)
end

puts start

# puts required_fuel(12) == 2
# puts required_fuel(14) == 2
# puts required_fuel(1969) == 654
# puts required_fuel(100756) == 33583
