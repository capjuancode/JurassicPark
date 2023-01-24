require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/v1/cages", type: :request do
  let!(:cage_with_dino) { create(:cage, :with_dino) }
  # This should return the minimal set of attributes required to create a valid
  # Cage. As you add validations to Cage, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    # skip("Add a hash of attributes valid for your model")
    {
      name: 'MyString',
      max_capacity: 3,
      status: :active
    }
  }

  let(:invalid_attributes) {
    # skip("Add a hash of attributes invalid for your model")
    {
      name: '',
      max_capacity: nil,
      status: :active
    }
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CagesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) { {} }

  describe "GET /index" do
    it "renders a successful response" do
      Cage.create! valid_attributes
      get v1_cages_url, headers: valid_headers, as: :json

      expect(response).to be_successful
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'search by diet' do
      Cage.create! valid_attributes

      params = { search_params: { diet: cage_with_dino.current_diet.to_s } }
      get v1_cages_url(params: params), headers: valid_headers, as: :json

      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get v1_cage_url(cage_with_dino), as: :json

      expect(response).to be_successful
      expect(JSON.parse(response.body)['id']).to eq(cage_with_dino.id)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Cage" do
        expect {
          post v1_cages_url,
               params: { cage: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Cage, :count).by(1)
      end

      it "renders a JSON response with the new v1_cage" do
        post v1_cages_url,
             params: { cage: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Cage" do
        expect {
          post v1_cages_url,
               params: { cage: invalid_attributes }, as: :json
        }.to change(Cage, :count).by(0)
      end

      it "renders a JSON response with errors for the new v1_cage" do
        post v1_cages_url,
             params: { cage: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(JSON.parse(response.body).first).to eq("Max capacity can't be blank")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "DINO Cage"
        }
      }

      it "updates the requested v1_cage" do
        initial_name = cage_with_dino.name
        patch v1_cage_url(cage_with_dino),
              params: { cage: new_attributes }, headers: valid_headers, as: :json

        expect(initial_name).to eq cage_with_dino.name
        expect(initial_name == cage_with_dino.reload.name).to eq false
      end

      it "renders a JSON response with the v1_cage" do
        patch v1_cage_url(cage_with_dino),
              params: { cage: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the v1_cage" do
        patch v1_cage_url(cage_with_dino),
              params: { cage: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested v1_cage" do
      expect {
        delete v1_cage_url(cage_with_dino), headers: valid_headers, as: :json
      }.to change(Cage, :count).by(-1)
    end
  end
end
