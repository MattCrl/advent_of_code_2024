def read_input_file(input_file)
  File.read(input_file).split(/\n/)
end

def solve_part_one(grid)
  x_position = 0 # left right
  y_position = 0 # top bottom
  current_direction = "^"
  distinct_positions = 0
  (0..grid.size - 1).each do |line_number|
    unless grid[line_number].index(current_direction).nil?
      x_position = grid[line_number].index(current_direction)
      y_position = line_number 
    end
  end
  b = true
  while b 
    if y_position < 0 || x_position < 0
      b = false
    end
    case current_direction
    when "^"
      if grid[y_position - 1].nil? || grid[y_position - 1][x_position].nil?
        b = false # on sort de la grille
      else
        if grid[y_position - 1][x_position] == "#"
          # swap 90°
          current_direction = ">"
        else
          # déplace au top, ajoute un X à la place ici
          grid[y_position][x_position] = "X"
          grid[y_position - 1][x_position] = "^"
          y_position -= 1
        end
      end
    when ">"
      if grid[y_position].nil? || grid[y_position][x_position + 1].nil?
        b = false # on sort de la grille
      else
        if grid[y_position][x_position + 1] == "#"
          # swap 90°
          current_direction = "v"
        else
          # déplace à droite, ajoute un X à la place ici
          grid[y_position][x_position] = "X"
          grid[y_position][x_position + 1] = ">"
          x_position += 1
        end
      end
    when "<"
      if grid[y_position].nil? || x_position <= 0
        b = false # on sort de la grille
      else
        if grid[y_position][x_position - 1] == "#"
          # swap 90°
          current_direction = "^"
        else
          # déplace à gauche, ajoute un X à la place ici
          grid[y_position][x_position] = "X"
          grid[y_position][x_position - 1] = "<"
          x_position -= 1
        end
      end
    when "v"
      if grid[y_position + 1].nil? || grid[y_position + 1][x_position].nil?
        b = false # on sort de la grille
      else
        if grid[y_position + 1][x_position] == "#"
          # swap 90°
          current_direction = "<"
        else
          # déplace en bas, ajoute un X à la place ici
          grid[y_position][x_position] = "X"
          grid[y_position + 1][x_position] = "v"
          y_position += 1
        end
      end
    else
      puts "Can't get there!"
    end
  end
  total = 0
    grid.each do |line|
      total += line.count("X")
    end
    total + 1 # +1 because the last direction is still present in the grid instead of a X
end

puts solve_part_one(read_input_file("./day_06/input.txt"))
