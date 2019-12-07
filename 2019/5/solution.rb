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
      command, first_param, second_param, third_param, steps = nil

      if instruction != 3 && instruction != 4
        command, first_param, second_param, third_param, steps = process_instruction(instruction)
      else
        command = instruction
        first_param = @final_state[@current_pointer + 1]
      end

      if command == 1
        add(first_param, second_param, third_param, steps)
      elsif command == 2
        multiply(first_param, second_param, third_param, steps)
      elsif command == 3
        set(first_param)
      elsif command == 4
        output(first_param)
      else
        binding.pry
      end
    end
  end

  def process_instruction(instruction)
    instructions = instruction.to_s.rjust(5, "0").split("").map(&:to_i).reverse
    a,b,c,d,e = 0

    e,d,c,b,a = instructions

    opcode = [d,e].join("").to_i

    c == 0 ? first_param = @final_state[@final_state[@current_pointer + 1]] : first_param = @final_state[@current_pointer + 1]
    b == 0 ? second_param = @final_state[@final_state[@current_pointer + 2]] : second_param = @final_state[@current_pointer + 2]
    third_param = @final_state[@current_pointer + 3]
    steps = 4 + c + b

    # binding.pry
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

  def output(position)
    puts @final_state[position]
    @current_pointer = @current_pointer + 2
  end
end

program = File.open("input.txt").read
computer = Computer.new(program)
computer.run
# puts computer.final_state


# computer = Computer.new("1002,4,3,4,33")
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
