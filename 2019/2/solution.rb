require "pry"

class Computer
  attr_reader :current_pointer, :initial_state

  def initialize(input)
    split_input = input.split(",").map(&:to_i)

    @final_state = split_input
    @initial_state = split_input
    @current_pointer = 0
  end

  def run
    while @final_state[@current_pointer] != 99
      if @final_state[@current_pointer] == 1
        add(@final_state[@current_pointer + 1], @final_state[@current_pointer + 2], @final_state[@current_pointer + 3])
      elsif @final_state[@current_pointer] == 2
        multiply(@final_state[@current_pointer + 1], @final_state[@current_pointer + 2], @final_state[@current_pointer + 3])
      else
        binding.pry
      end
    end
  end

  def final_state
    @final_state.join(",")
  end

  def add(left, right, result)
    @final_state[result] = @final_state[left] + @final_state[right]
    @current_pointer = @current_pointer + 4
  end

  def multiply(left, right, result)
    @final_state[result] = @final_state[left] * @final_state[right]
    @current_pointer = @current_pointer + 4
  end
end

program = File.open("input.txt").read
computer = Computer.new(program)
computer.run
puts computer.final_state


# computer = Computer.new("1,0,0,0,99")
# computer.run
# puts computer.final_state
# puts computer.final_state == "2,0,0,0,99"
#
# computer = Computer.new("2,3,0,3,99")
# computer.run
# puts computer.final_state
# puts computer.final_state == "2,3,0,6,99"
#
# computer = Computer.new("2,4,4,5,99,0")
# computer.run
# puts computer.final_state
# puts computer.final_state == "2,4,4,5,99,9801"
#
# computer = Computer.new("1,1,1,4,99,5,6,0,99")
# computer.run
# puts computer.final_state
# puts computer.final_state == "30,1,1,4,2,5,6,0,99"
