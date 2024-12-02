def read_input_file(input_file)
  File.read(input_file).split("\n")
end

def diff_acceptable?(report, min_acceptable, max_acceptable)
  report.each_cons(2).all? { |a, b| ((b - a).abs >= min_acceptable) && ((b - a).abs <= max_acceptable) }
end

def is_sorted?(report)
  (report == report.sort) || (report == report.sort { |a, b| b <=> a })
end

def solve_part_one(inputs)
  valid_count = 0
  inputs.each do |report|
    report = report.split.map(&:to_i) 
    if diff_acceptable?(report, 1, 3) && is_sorted?(report)
      valid_count += 1
    end
  end
  valid_count
end

puts solve_part_one(read_input_file("./day_02/input.txt"))


