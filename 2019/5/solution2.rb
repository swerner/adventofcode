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
      instruction = @final_state[@current_pointer]
      command, first_param, second_param, third_param, steps = process_instruction(instruction)

      if command == 1
        add(first_param, second_param, third_param, steps)
      elsif command == 2
        multiply(first_param, second_param, third_param, steps)
      elsif command == 3
        set(first_param)
      elsif command == 4
        output(first_param)
      elsif command == 5
        jump_if_true(first_param, second_param)
      elsif command == 6
        jump_if_false(first_param, second_param)
      elsif command == 7
        less_than(first_param, second_param, third_param)
      elsif command == 8
        equals(first_param, second_param, third_param)
      else
        binding.pry
      end
    end
  end

  def jump_if_false(test, new_loc)
    if test == 0
      @current_pointer = new_loc
    else
      @current_pointer = @current_pointer + 3
    end
  end

  def jump_if_true(test, new_loc)
    if test == 0
      @current_pointer = @current_pointer + 3
    else
      @current_pointer = new_loc
    end
  end

  def less_than(left, right, result)
    left < right ? @final_state[result] = 1 : @final_state[result] = 0
    @current_pointer = @current_pointer + 4
  end

  def equals(left, right, result)
    left == right ? @final_state[result] = 1 : @final_state[result] = 0
    @current_pointer = @current_pointer + 4
  end

  def process_instruction(instruction)
    instructions = instruction.to_s.rjust(5, "0").split("").map(&:to_i).reverse
    a,b,c,d,e = 0

    e,d,c,b,a = instructions

    opcode = [d,e].join("").to_i

    c == 0 && (opcode != 3) ? first_param = @final_state[@final_state[@current_pointer + 1]] : first_param = @final_state[@current_pointer + 1]
    b == 0 ? second_param = @final_state[@final_state[@current_pointer + 2]] : second_param = @final_state[@current_pointer + 2]
    third_param = @final_state[@current_pointer + 3]
    steps = 4 + c + b

    [opcode, first_param, second_param, third_param, steps]
  end

  def final_state
    @final_state.join(",")
  end

  def add(left, right, result, steps)
    @final_state[result] = left + right
    @current_pointer = @current_pointer + 4
  end

  def multiply(left, right, result, steps)
    @final_state[result] = left * right
    @current_pointer = @current_pointer + 4
  end

  def set(position)
    puts "Enter Value: "
    value = gets
    @final_state[position] = value.chomp.to_i
    @current_pointer = @current_pointer + 2
  end

  def output(first_param)
    puts first_param

    @current_pointer = @current_pointer + 2
  end
end

program = File.open("input.txt").read
computer = Computer.new(program)
computer.run
# puts computer.final_state


# Equality / Less than tests
# puts "1st"
# computer = Computer.new("3,9,8,9,10,9,4,9,99,-1,8")
# computer.run
#
# puts "2nd"
# computer = Computer.new("3,9,8,9,10,9,4,9,99,-1,8")
# computer.run
#
# puts "3rd"
# computer = Computer.new("3,9,7,9,10,9,4,9,99,-1,8")
# computer.run
#
# puts "4th"
# computer = Computer.new("3,9,7,9,10,9,4,9,99,-1,8")
# computer.run
#
# puts "5th"
# computer = Computer.new("3,3,1108,-1,8,3,4,3,99")
# computer.run
#
# puts "6th"
# computer = Computer.new("3,3,1108,-1,8,3,4,3,99")
# computer.run
#
# puts "7th"
# computer = Computer.new("3,3,1107,-1,8,3,4,3,99")
# computer.run
#
# puts "8th"
# computer = Computer.new("3,3,1107,-1,8,3,4,3,99")
# computer.run
#
# Jump Tests
#
# computer = Computer.new("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
# computer.run
#
# computer = Computer.new("3,3,1105,-1,9,1101,0,0,12,4,12,99,1")
# computer.run
#
# Larger Example
#
# puts "Less than 8"
# computer = Computer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
# computer.run
#
# puts "Equal to 8"
# computer = Computer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
# computer.run
#
# puts "Greater than 8"
# computer = Computer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
# computer.run
