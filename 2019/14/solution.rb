require "pry"

class ReactionList
  attr_reader :reactions

  def initialize(input)
    @reactions = input.split("\n").map{ |line| Reaction.new(line) }
  end

  def reaction_that_makes(output)
    @reactions.select{ |reaction| reaction.output_element == output }[0]
  end

  def ore_to_make(amount, element)
    reaction = reaction_that_makes(element)

    if(amount <= reaction.output_amount)
      reaction.inputs[0][0]
    else
      amount % reaction.output_amount == 0 ? (amount / reaction.output_amount) * reaction.inputs[0][0] : (amount / reaction.output_amount + 1) * reaction.inputs[0][0]
    end
  end
end

class Reaction
  attr_reader :inputs, :output_element, :output_amount

  def initialize(reaction)
    @inputs = []
    left, right = reaction.split(" => ")
    @output_amount, @output_element = [right.split(" ")[0].to_i,right.split(" ")[1]]
    left.split(", ").each do |input|
      @inputs << [input.split(" ")[0].to_i, input.split(" ")[1]]
    end
  end

  def ore_reaction?
    @inputs.any? { |input| input[1] == "ORE" }
  end

  def to_s
    "#{@inputs.join(" ")} => #{@output_amount} #{@output_element}"
  end
end

input1 = "10 ORE => 10 A
1 ORE => 1 B
7 A, 1 B => 1 C
7 A, 1 C => 1 D
7 A, 1 D => 1 E
7 A, 1 E => 1 FUEL"

input2 = "9 ORE => 2 A
8 ORE => 3 B
7 ORE => 5 C
3 A, 4 B => 1 AB
5 B, 7 C => 1 BC
4 C, 1 A => 1 CA
2 AB, 3 BC, 4 CA => 1 FUEL"

input3 = "157 ORE => 5 NZVS
165 ORE => 6 DCFZ
44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
179 ORE => 7 PSHF
177 ORE => 5 HKGWZ
7 DCFZ, 7 PSHF => 2 XJWVT
165 ORE => 2 GPVTF
3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT"

input4 = "2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
17 NVRVD, 3 JNWZP => 8 VPVL
53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
22 VJHF, 37 MNCFX => 5 FWMGM
139 ORE => 4 NVRVD
144 ORE => 7 JNWZP
5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
145 ORE => 6 MNCFX
1 NVRVD => 8 CXFTF
1 VJHF, 6 MNCFX => 4 RFSQX
176 ORE => 6 VJHF"

input5= "171 ORE => 8 CNZTR
7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
114 ORE => 4 BHXH
14 VRPVC => 6 BMBT
6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
5 BMBT => 4 WPTQ
189 ORE => 9 KTJDG
1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
12 VRPVC, 27 CNZTR => 2 XDBXC
15 KTJDG, 12 BHXH => 5 XCVML
3 BHXH, 2 VRPVC => 7 MZWV
121 ORE => 7 VRPVC
7 XCVML => 6 RJRHP
5 BHXH, 4 VRPVC => 5 LTCX"

puzzle_input = File.open("input.txt").read

@reactionList = ReactionList.new(input5)
fuel_reaction = @reactionList.reaction_that_makes("FUEL")
requirements = Hash.new(0)
leftovers = Hash.new(0)

fuel_reaction.inputs.each do |input|
  requirements[input[1]] = requirements[input[1]] + input[0]
end

puts requirements

while !requirements.all? { |k, v| @reactionList.reaction_that_makes(k).ore_reaction? }
    requirement = requirements.select { |k, v| !@reactionList.reaction_that_makes(k).ore_reaction? }.keys[0]

  # unreduced_requirements.each do |element, amount|
    amount = requirements[requirement]
    element = requirement
    requirements.delete element

    reaction = @reactionList.reaction_that_makes(element)

    output_amount = reaction.output_amount
    multiplier = 1
    leftover = 0

    if amount > output_amount
      multiplier = amount % output_amount == 0 ? (amount / output_amount) : (amount / output_amount + 1)
    end

    reaction.inputs.each do |input|
      requirements[input[1]] = requirements[input[1]] + input[0] * multiplier
    end
    puts requirements
    puts leftovers
  # end
end

# def fill_requirements(base_requirements, inputs)
#   inputs.each do |input|
#     input_reaction = @reactionList.reaction_that_makes(input[1])
#
#     if input_reaction.ore_reaction?
#       base_requirements[input[1]] = base_requirements[input[1]] + input[0]
#     else
#       amount = input[0]
#       output_amount = input_reaction.output_amount
#
#       if amount <= output_amount
#         fill_requirements(base_requirements, input_reaction.inputs)
#       else
#         num_times = amount % output_amount == 0 ? amount / output_amount : amount / output_amount + 1
#         num_times.times { fill_requirements(base_requirements, input_reaction.inputs) }
#       end
#     end
#   end
# end

# fill_requirements(requirements, fuel_reaction.inputs)
# puts requirements


puts requirements.sum { |k, v| @reactionList.ore_to_make(v, k) }
# puts @reactionList.ore_to_make(8, "PSHF")
