class DinoSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :species
end
