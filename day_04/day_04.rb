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
      if grid_height >= line_number + word_size
        word = grid[line_number][letter_number]
        if word == "X" || word == "S" # si on est pas sur un X, inutile de chercher la suite
          (1..3).each do |i|
            word << grid[line_number + i][letter_number]
          end
          if word == "XMAS" || word == "SAMX"
            total_matches += 1
          end
        end
        
        # recherche diagonale bas droite possible
        if letter_number + word_size <= grid_length
          word = grid[line_number][letter_number]
          if word == "X" || word == "S" # si on est pas sur un X, inutile de chercher la suite
            (1..3).each do |i|
              word << grid[line_number + i][letter_number + i]
            end
            if word == "XMAS" || word == "SAMX"
              total_matches += 1
            end
          end
        end

        # recherche diagonale bas gauche possible
        if letter_number - word_size >= 0
          word = grid[line_number][letter_number]
          if word == "X" || word == "S" # si on est pas sur un X, inutile de chercher la suite
            (1..3).each do |i|
              word << grid[line_number + i][letter_number - i]
            end
            if word == "XMAS" || word == "SAMX"
              total_matches += 1
            end
          end
        end
      end
    end
  end
  total_matches
end

puts solve_part_one(read_input_file("./day_04/input_example.txt")) # renvoi 18
puts solve_part_one(read_input_file("./day_04/input.txt"))
