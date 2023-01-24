class CageSerializer < ActiveModel::Serializer
  attributes :id, :name, :max_capacity, :status, :current_capacity, :available_capacity
  has_many :dinos

  def current_capacity
    current_capacity ||= object.dinos.count
  end

  def available_capacity
    object.max_capacity - current_capacity
  end
end
