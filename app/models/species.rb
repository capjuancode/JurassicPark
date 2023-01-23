class Species < ApplicationRecord
  has_many :dinos

  enum diet: { 'carnivore': 0, 'herbivore': 1 }
end
