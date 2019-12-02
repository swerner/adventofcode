require "pry"

def required_fuel(mass)
  fuel = mass / 3 - 2

  return 0 if fuel <= 0
  return fuel + required_fuel(fuel)
end

input = File.open('input.txt').read.split("\n")

start = 0

input.each do |item|
  start = start + required_fuel(item.to_i)
  puts required_fuel(item.to_i)
end

puts start



# puts required_fuel(14) == 2
# puts required_fuel(14)
# puts required_fuel(1969) == 966
# puts required_fuel(1969)
# puts required_fuel(100756) == 50346
# puts required_fuel(100756)
