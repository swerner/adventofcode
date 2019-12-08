require "pry"

pixels = File.open("input.txt").read.split("").map(&:to_i)

def pixels_to_layers(pixels, width, length)
    pixels.each_slice(width * length).to_a
end

def output_layer(layer, width)
  layer.each_slice(width) do |line|
    puts line.join("")
  end
end

def combine_layers(first, second)
  combined = Array.new(first.length)

  combined.each_with_index do |pixel, index|
    combined[index] = first[index]
    combined[index] = second[index] unless second[index] == 2
    combined[index] = " " if combined[index] == 0
  end

  combined
end

# output = pixels_to_layers("123456789012".split("").map(&:to_i), 3, 2)
#
# puts output[0]
# gets
# puts output[1]

# puts pixels_to_layers(pixels, 25, 6)
output = pixels_to_layers(pixels, 25, 6)

first_layer = output.reverse[1]
layer_to_output = first_layer

output.reverse[2..-1].each do |layer|
  layer_to_output = combine_layers(layer_to_output, layer)
end

output_layer(layer_to_output, 25)
# puts correct_layer.count(1) * correct_layer.count(2)
