class CombinationCalculator
  attr_reader :array, :operators

  def initialize(array, operators)
    @array = array
    @operators = operators
  end

  def calculate_combinations
    operator_combinations.map { |ops| evaluate_combination(ops) }
  end

  private

  def operator_combinations
    @operators.repeated_permutation(@array.size - 1).to_a
  end

  def evaluate_combination(ops)
    result = @array.first
    ops.each_with_index do |op, index|
      result = result.send(op, @array[index + 1])
    end
    result
  end
end

def read_input_file(input_file)
  File.read(input_file).split(/\n/)
end

def solve_part_one(input)
  total = 0
  input.each do |line|
    a = line.split(': ')
    test_value = a[0].to_i
    numbers = a[1].split.map(&:to_i)
    calculator = CombinationCalculator.new(numbers, [:+, :*])
    results = calculator.calculate_combinations
    total += test_value if results.include? test_value
  end
  total
end

puts solve_part_one(read_input_file('./day_07/input.txt'))
