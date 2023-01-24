class Cage < ApplicationRecord
  include Searchable

  has_many :dinos
  has_many :species, through: :dinos

  validate :no_power_down
  validates :max_capacity, presence: true

  enum status: { 'down': 0, 'active': 1 }

  # Searchable
  # Cage.search({ name: 'Tyra', status: 'active', diet: 'carnivore' })
  scope :by_name, ->(name) { where('lower(cages.name) LIKE ?', "%#{name&.strip&.downcase}%") }
  scope :by_status, ->(status) { where(status: status) }
  scope :by_diet, ->(diet) { left_joins(:species).where(species: { diet: diet }).uniq }

  #
  # Check if there is dinos in the cage before its shutdown
  #
  # @return [<boolean>]
  #
  def no_power_down
    return true if !status_changed?(from: 'active', to: 'down') ||
                    (status_changed?(from: 'active', to: 'down') && dinos.empty?)

    errors.add(:cage, 'status cant be Downed until Dinos are relocated, watch video documentary...  Jurassic Park, Jurassic World')
  end

  #
  # Check all Dinos diet and make sure they are all the same if not raise and error
  #
  # @return [<String#diet_type | nil>]
  #
  def current_diet
    diet = species.pluck(:diet).uniq

    return if diet.count.zero?
    return diet.first if diet.count == 1

    raise "Wrong Species Diet Mix, Check if Dino's are still Alive"
  end

  #
  # Check all Dinos species and makes sure they are all the same if not raise and error
  #
  # @return [<String#species_type/name | nil>]
  #
  def same_species_type
    type = species.pluck(:name).uniq

    return if type.count.zero?
    return type.first if type.count == 1

    raise "Wrong Species type, Check if Dino's are still Alive"
  end

  def full?
    dinos.count >= max_capacity
  end
end
