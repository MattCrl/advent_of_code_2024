def read_input_file(input_file)
  File.read(input_file)
end

def solve_part_one(inputs)
  total = 0
  correct_instructions = inputs.scan(/mul\([0-9]{1,3},[0-9]{1,3}\)/)
  correct_instructions.each do |instruction|
    numbers = instruction.scan(/[0-9]{1,3}/).map &:to_i
    total += (numbers.first * numbers.last)
  end
  total
end

puts solve_part_one(read_input_file("./day_03/input.txt"))
