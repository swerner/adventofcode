require "pry"

pixels = File.open("input.txt").read.split("").map(&:to_i)

def pixels_to_layers(pixels, width, length)
    pixels.each_slice(width * length).to_a
end

# output = pixels_to_layers("123456789012".split("").map(&:to_i), 3, 2)
#
# puts output[0]
# gets
# puts output[1]

# puts pixels_to_layers(pixels, 25, 6)
output = pixels_to_layers(pixels, 25, 6)

correct_layer = output.sort { |a, b| a.count(0) <=> b.count(0) }[1]
output_layer(correct_layer, width, length)
puts correct_layer.count(1) * correct_layer.count(2)
