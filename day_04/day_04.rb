def read_input_file(input_file)
  File.read(input_file).split("\n")
end

def solve_part_one(grid)
  total_matches = 0
  word_size = 3 # XMAS size - 1 car recherche dans des tableaux
  # recherche horizontale (j'élimine le fait de devoir rechercher à gauche et à droite)
  grid.each do |line|
    total_matches += line.scan(/(?=(XMAS|SAMX))/).count
  end

  # Pour la suite, comme je vais rechercher sur XMAS et SAMX, j'ai pas besoin de chercher dans les deux sens
  # Je peux chercher que dans le sens de la descente pour éviter de doubler toutes les recherches
  # Exemple : rechercher vers le bas "SAMX" équivaut à rechercher vers le haut "XMAS" donc je gagne du temps
  grid_length = grid[0].size - 1
  grid_height = grid.size - 1
  (0..grid_length).each do |line_number|
    (0..grid_height).each do |letter_number|
      # recherche bas possible
      next unless grid_height >= line_number + word_size

      word = grid[line_number][letter_number]
      if %w[X S].include?(word) # si on est pas sur un X ou S, inutile de chercher la suite
        (1..3).each do |i|
          word << grid[line_number + i][letter_number]
        end
        total_matches += 1 if %w[XMAS SAMX].include?(word)
      end

      # recherche diagonale bas droite possible
      if letter_number + word_size <= grid_length
        word = grid[line_number][letter_number]
        if %w[X S].include?(word) # si on est pas sur un X ou S, inutile de chercher la suite
          (1..3).each do |i|
            word << grid[line_number + i][letter_number + i]
          end
          total_matches += 1 if %w[XMAS SAMX].include?(word)
        end
      end

      # recherche diagonale bas gauche possible
      next unless letter_number - word_size >= 0

      word = grid[line_number][letter_number]
      next unless %w[X S].include?(word) # si on est pas sur un X ou S, inutile de chercher la suite

      (1..3).each do |i|
        word << grid[line_number + i][letter_number - i]
      end
      total_matches += 1 if %w[XMAS SAMX].include?(word)
    end
  end
  total_matches
end

puts solve_part_one(read_input_file('./day_04/input_example.txt')) # renvoi 18
puts solve_part_one(read_input_file('./day_04/input.txt'))

def solve_part_two(grid)
  total_matches = 0
  word_size = 2 # "MAS" size - 1

  grid_length = grid[0].size - 1
  grid_height = grid.size - 1
  (0..grid_length).each do |line_number|
    (0..grid_height).each do |letter_number|
      # je vais chercher en croix que dans le sens bas droite
      next unless grid_height >= line_number + word_size

      # recherche bas possible
      next unless letter_number + word_size <= grid_length

      # recherche droite possible
      word = grid[line_number][letter_number]
      next unless %w[M S].include?(word) # si on est pas sur un M ou S, inutile de chercher la suite

      (1..2).each do |i|
        word << grid[line_number + i][letter_number + i]
      end
      word_2 = grid[line_number][letter_number + 2] + grid[line_number + 1][letter_number + 1] + grid[line_number + 2][letter_number]
      total_matches += 1 if %w[MAS SAM].include?(word) && %w[MAS SAM].include?(word_2)
    end
  end
  puts total_matches
end

puts solve_part_two(read_input_file('./day_04/input_example.txt')) #  renvoi bien 9
puts solve_part_two(read_input_file('./day_04/input.txt'))
