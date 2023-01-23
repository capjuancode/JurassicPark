class Dino < ApplicationRecord
  include Searchable

  belongs_to :species
  belongs_to :cage

  validate :same_species, if: :carnivore_changing_cage?
  validate :can_enter_cage?, if: :cage_changed?
  validate :no_dino_in_down_cage, :space_available

  delegate :diet, to: :species

  # Searchable
  # Dino.search({ name: 'spi', species_name: 'Spino', species_diet: 'carnivore' })
  scope :by_name, ->(name) { where('lower(dinos.name) LIKE ?', "%#{name&.strip&.downcase}%") }
  scope :by_species_name, ->(name) { joins(:species).where('lower(species.name) LIKE ?', "%#{name&.strip&.downcase}%") }
  scope :by_species_diet, ->(diet) { joins(:species).where(species: { diet: diet }) }

  #
  # check if dino is being move to another cage that is downed
  #
  # @return [<boolean>]
  #
  def no_dino_in_down_cage
    return true if cage_changed? && cage.active?

    errors.add(:cage, 'is downed must activate first, watch video documentary...  Jurassic Park or/and Jurassic World')
  end

  #
  # checks if its a carnivore getting assign a new cage
  #
  # @return [<boolean>]
  #
  def carnivore_changing_cage?
    cage_changed? && carnivore?
  end

  #
  # Checks Dino diet is a carnivore
  #
  # @return [<boolean>]
  #
  def carnivore?
    species.carnivore?
  end

  #
  # validates is Dino Name/Type is same as the other do too being a carnivore
  #
  # @return [boolean]
  #
  def same_species
    return true if cage.same_species_type.nil? || cage.same_species_type == species.name

    errors.add(:cage, ' Species type/name incompatible with this dinosaur')
  end

  #
  # validates is Dino diet is same as the others
  #
  # @return [boolean]
  #
  def can_enter_cage?
    return true if cage.current_diet.nil? || cage.current_diet == diet

    errors.add(:cage, ' Diet incompatible with this dinosaur')
  end

  #
  # validates that theirs space on specific cage
  #
  # @return [boolean]
  #
  def space_available
    return true unless cage.full?

    errors.add(:cage, ' its Full cant add more Dinos')
  end
end
