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
  # initialisation du Hash qui permet de créer un tableau vide pour l'ajout d'une nouvelle clé qui n'existe pas encore dans le Hash
  all_rules = Hash.new { |h, k| h[k] = [] }
  page_rules.each do |rule|
    rule_split = rule.split("|").map &:to_i
    all_rules[rule_split[0]] << rule_split[1]
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

require 'set'

def solve_part_two
  sections = File.read("./day_05/input.txt").split("\n\n").map { |section| section.split("\n") }
  parsed_rules = sections[0].map { |rule| rule.split('|') }
  updates = sections[1].map { |update| update.split(',') }
  puts "parsed_rules #{parsed_rules}"
  puts "updates #{updates}"
  rules = {}
  
  parsed_rules.each do |first, second|
    (rules[first] ||= Set.new) << second
  end
  
  updates.map { |update|
    if check_order(update, rules)
      0
    else
      fixed = fix_update(update, rules)
      fixed[fixed.length.fdiv(2)].to_i
    end
  }.sum
end

def check_order(update, rules)
  update.each_cons(2) do |i, j|
    return false if rules[i].nil? || !rules[i].include?(j)
  end
  true
end

def fix_update(update, rules)
  update.sort { |a, b| !rules[a].nil? && rules[a].include?(b) ? 1 : -1 }
end

puts solve_part_two



# Perdu énormément de temps avec cette solution pour la partie 2, car l'input final contient une boucle infinie dans les cycles...
# Fonctionne pour l'input d'exemple mais pas avec l'input final 
# def solve_part_two_failed(inputs)
#   total = 0
#   page_rules = inputs[0].split(/\n/)
#   page_updates = inputs[1].split(/\n/).map{_1.split(",")}.map{_1.map(&:to_i)}
#   all_rules = page_rules.map{_1.split("|")}.map{_1.map(&:to_i)}
#   # initialisation du Hash qui permet de créer un tableau vide pour l'ajout d'une nouvelle clé qui n'existe pas encore dans le Hash
#   rules_hash = Hash.new { |h, k| h[k] = [] } 
#   # pareil que pour l'autre Hash sauf qu'ici ce sera 0 la valeur par défaut
#   page_depends_time = Hash.new(0) 
#   all_rules.each do |rule|
#     left_page, right_page = rule[0], rule[1]
#     rules_hash[left_page] << right_page
#     page_depends_time[left_page] += 0  # Permet de s'assurer qu'une entrée est créée dans le Hash au cas où la page de gauche n'est dépendante d'aucune autre
#     page_depends_time[right_page] += 1  # Augmente de 1 le nombre de dépendance de la page de droite
#   end

#   ordered_pages_with_rules = []
  
#   # La boucle me permet de trouver quel page n'a plus de dépendances et de l'ajouter au résultat
#   # Une fois une page ajoutée au résultat je met à jour le compteur des autres pages
#   while page_depends_time.any?
#     # Trouver un nœud sans dépendances
#     noeud = page_depends_time.find { |_, compteur| compteur == 0 }&.first
#     if noeud.nil?
#       puts "BOUCLE INFINIE -> FAIL"
#       return "RIP"
#     end
#     ordered_pages_with_rules << noeud
#     page_depends_time.delete(noeud)
#     rules_hash[noeud].each do |successeur|
#       page_depends_time[successeur] -= 1
#     end
#   end
#   ordered_pages_with_rules
# end

#puts solve_part_two_failed(read_input_file("./day_05/input_example.txt")) 
