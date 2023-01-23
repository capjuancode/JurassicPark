require "rails_helper"

RSpec.describe V1::SpeciesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/species").to route_to("v1/species#index")
    end

    it "routes to #show" do
      expect(get: "/v1/species/1").to route_to("v1/species#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/species").to route_to("v1/species#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/species/1").to route_to("v1/species#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/species/1").to route_to("v1/species#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/species/1").to route_to("v1/species#destroy", id: "1")
    end
  end
end
