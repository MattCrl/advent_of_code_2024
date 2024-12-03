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

def split_with_separators(string_in)
  string_in.split(/(?=(do\(\)|don't\(\)))/).reject(&:empty?)
end

def solve_part_two(inputs)
  total = 0
  do_dont_splitting = split_with_separators(inputs)
  do_dont_splitting.each do |instruction|
    unless instruction.start_with?("don't()")
      correct_instructions = instruction.scan(/mul\([0-9]{1,3},[0-9]{1,3}\)/)
      correct_instructions.each do |instruction|
        numbers = instruction.scan(/[0-9]{1,3}/).map &:to_i
        total += (numbers.first * numbers.last)
      end
    end
  end
  total
end

puts solve_part_two(read_input_file("./day_03/input.txt"))
