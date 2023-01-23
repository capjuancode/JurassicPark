# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

%w[Tyrannosaurus Spinosaurus Megalosaurus].each do |name|
  Species.create(name: name, diet: :carnivore)
end

%w[Brachiosaurus Stegosaurus Ankylosaurus Triceratops].each do |name|
  Species.create(name: name, diet: :herbivore)
end

Species.where(diet: :carnivore).each do |species|
  cage = Cage.create(name: species.name.pluralize, max_capacity: 2, status: :active)
  Dino.create(name: species.name.first(6), species: species, cage: cage)
end

cage = Cage.create(name: 'Herbivores', max_capacity: 20, status: :active)
Species.where(diet: :herbivore).each do |species|
  Dino.create(name: species.name.first(6), species: species, cage: cage)
end

velociraptor = Species.create(name: 'Velociraptor', diet: :carnivore)
cage = Cage.create(name: velociraptor.name.pluralize, max_capacity: 5, status: :active)

%w[Delta Echo Charlie Blue].each do |name|
  Dino.create(name: name, species: velociraptor, cage: cage)
end
