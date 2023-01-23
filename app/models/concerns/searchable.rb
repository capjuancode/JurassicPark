module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(filtering_params)
      results = all
      filtering_params.each do |key, value|
        results = results.public_send("by_#{key}", value) if value.present?
      end
      results
    end
  end
end
