class Species < ApplicationRecord
  include Searchable

  has_many :dinos

  enum diet: { 'carnivore': 0, 'herbivore': 1 }

  # Searchable
  # Species.search({ name: 'spi', diet: 'carnivore' })
  scope :by_name, ->(name) { where('lower(species.name) LIKE ?', "%#{name&.strip&.downcase}%") }
  scope :by_diet, ->(diet) { where(diet: diet) }

end
