class SpeciesSerializer < ActiveModel::Serializer
  attributes :id, :name, :diet

  has_many :dinos
end
