class CageSerializer < ActiveModel::Serializer
  attributes :id, :name, :max_capacity, :status, :current_capacity?, :available_capacity?

  def current_capacity?
    5
  end

  def available_capacity?
    max_capacity - current_capacity?
  end
end
