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

def create_sub_arrays(initial_report)
  save_initial_report = initial_report
  sub_reports = initial_report.each_index.map do |index|
    initial_report.reject.with_index { |_, i| i == index }
  end
  sub_reports
end

def solve_part_two(inputs)
  valid_count = 0
  sub_valid = false
  inputs.each do |report|
    report = report.split.map(&:to_i) 
    if diff_acceptable?(report, 1, 3) && is_sorted?(report)
      valid_count += 1
    else
      sub_reports = create_sub_arrays(report)
      sub_reports.each do |sub_report|
        if diff_acceptable?(sub_report, 1, 3) && is_sorted?(sub_report)
          sub_valid = true
        end
      end
      valid_count += 1 if sub_valid
      sub_valid = false
    end
  end
  valid_count
end

puts solve_part_two(read_input_file("./day_02/input.txt"))

