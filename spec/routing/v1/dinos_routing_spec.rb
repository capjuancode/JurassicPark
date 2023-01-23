require "rails_helper"

RSpec.describe V1::DinosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/dinos").to route_to("v1/dinos#index")
    end

    it "routes to #show" do
      expect(get: "/v1/dinos/1").to route_to("v1/dinos#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/dinos").to route_to("v1/dinos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/dinos/1").to route_to("v1/dinos#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/dinos/1").to route_to("v1/dinos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/dinos/1").to route_to("v1/dinos#destroy", id: "1")
    end
  end
end
