def read_input_file(input_file)
  File.read(input_file).split("\n")
end

# returns 2 arrays
def split_input_arrays
  inputs = read_input_file('./day_01/input.txt')

  distance_list_1 = []
  distance_list_2 = []

  inputs.each do |line|
    line_splitted = line.split('   ')
    distance_list_1 << line_splitted[0].to_i
    distance_list_2 << line_splitted[1].to_i
  end

  [distance_list_1, distance_list_2]
end

def solve_part_one(_inputs)
  distance_list_1, distance_list_2 = split_input_arrays
  distance_list_1 = distance_list_1.sort
  distance_list_2 = distance_list_2.sort

  total = 0
  distance_list_1.count.times do |i|
    total += (distance_list_1[i] - distance_list_2[i]).abs
  end

  total
end

puts solve_part_one(read_input_file('./day_01/input.txt'))

def solve_part_two(_inputs)
  distance_list_1, distance_list_2 = split_input_arrays

  total = 0
  distance_list_1.each do |current_distance|
    total += (current_distance * distance_list_2.count(current_distance))
  end

  total
end

puts solve_part_two(read_input_file('./day_01/input.txt'))
