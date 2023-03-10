require "rails_helper"

RSpec.describe V1::CagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/cages").to route_to("v1/cages#index")
    end

    it "routes to #show" do
      expect(get: "/v1/cages/1").to route_to("v1/cages#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/cages").to route_to("v1/cages#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/cages/1").to route_to("v1/cages#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/cages/1").to route_to("v1/cages#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/cages/1").to route_to("v1/cages#destroy", id: "1")
    end
  end
end
