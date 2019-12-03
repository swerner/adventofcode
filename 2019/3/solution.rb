require "pry"

class WirePlotter
  def initialize(wire1, wire2)
    @wire1 = wire1
    @wire1_locations = [[0,0]]
    @wire2 = wire2
    @wire2_locations = [[0,0]]

    @wire1_locations = plot(@wire1)
    @wire2_locations = plot(@wire2)
  end

  def plot(wire)
    locations = [[0,0]]
    commands = wire.split(",")

    commands.each do |command|
      direction = command.split("")[0]
      amount = command.split("")[1..-1].join.to_i
      current_location = locations[-1]

      case direction
      when "R"
        amount.times do |i|
          locations << [current_location[0], current_location[1] + (i+1)]
        end
      when "L"
        amount.times do |i|
          locations << [current_location[0], current_location[1] - (i+1)]
        end
      when "U"
        amount.times do |i|
          locations << [current_location[0] + (i+1), current_location[1]]
        end
      when "D"
        amount.times do |i|
          locations << [current_location[0] - (i+1), current_location[1]]
        end
      end
    end
    locations
  end

  def wire_crosses
    intersections = @wire1_locations & @wire2_locations
  end

  def closest_cross
    wire_crosses[1..-1].min do |a, b|
      a[0].abs + a[1].abs <=> b[0].abs + b[1].abs
    end.sum
  end
end

data = File.open("input.txt").read.split("\n")
plotter = WirePlotter.new(data[0], data[1])
puts plotter.closest_cross

# plotter = WirePlotter.new("R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83")
# puts plotter.closest_cross
# puts plotter.closest_cross == 159
#
# plotter = WirePlotter.new("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
# puts plotter.closest_cross
# puts plotter.closest_cross == 135
