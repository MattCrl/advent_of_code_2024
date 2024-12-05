def read_input_file(input_file)
  File.read(input_file).split(/\n{2,}/)
end

# Ma logique pour résoudre cet exercice :
# Je crée un Hash qui contient, pour chaque page dont une règle est présente, toutes les pages dont elle est dépendante
# Chaque clé du Hash (numéro de page) contient donc un tableau qui correspond à toutes les pages qui ne peuvent pas être imprimées APRÈS la page "clé"
# Ensuite je prends toutes les updates (2e partie de l'input), j'inverse chacune d'elles car c'est plus simple de les parcourir en sens inverse
# Puis, pour chaque page dans l'update, je vérifie en l'utilisant comme clé dans mon Hash si elle contient au moins une des pages suivante de l'update
# Si la clé contient une des pages suivantes, ça veut dire que l'update n'est pas valide
def solve_part_one(inputs)
  total = 0
  page_rules = inputs[0].split(/\n/)
  page_updates = inputs[1].split(/\n/).map{_1.split(",")}.map{_1.map(&:to_i)}
  all_rules = build_rules_hash(page_rules)

  page_updates.each do |update|
    total += update[update.size / 2] if update_is_valid(update, all_rules)
  end
  total
end

def build_rules_hash(page_rules)
  all_rules = Hash.new
  page_rules.each do |rule|
    rule_split = rule.split("|").map &:to_i
    if all_rules[rule_split[0]].nil? 
      all_rules[rule_split[0]] = [rule_split[1]]
    else
      all_rules[rule_split[0]] << rule_split[1]
    end
  end
  all_rules
end

def update_is_valid(update, rules_list)
  update = update.reverse
    is_valid = true
    i = 1
    update.each do |page_number|
      unless rules_list[page_number].nil?
        if rules_list[page_number].intersection(update.last(update.size - i)).any?
          is_valid = false
        end
      end
      i += 1
    end
    is_valid
end


puts solve_part_one(read_input_file("./day_05/input_example.txt"))
puts solve_part_one(read_input_file("./day_05/input.txt"))
