require 'rails_helper'

RSpec.describe Cage, type: :model do
  let(:cage_with_dino) { create(:cage, :with_dino) }

  context 'Validation' do

    it "can't power down if dinos present" do
      expect(cage_with_dino.update(status: :down)).to eq false
    end

    it 'power down if dinos not present' do
      cage_with_dino.dinos.each(&:delete)
      expect(cage_with_dino.reload.update(status: :down)).to eq true
    end
  end

  context 'Instance Methods' do
    let(:cage_with_vegan_dino) { create(:cage, :with_dino_vegan)}
    it "#current_diet check's all Dinos diet and make sure they are all the same - carnivore" do
      expect(cage_with_dino.current_diet).to eq 'carnivore'
    end

    it "#current_diet check's all Dinos diet and make sure they are all the same - herbivore" do
      expect(cage_with_vegan_dino.current_diet).to eq 'herbivore'
    end

    it "#same_species_type check's all Dinos species and make sure they are all the same - herbivore" do
      expect(cage_with_vegan_dino.same_species_type).to eq 'Vegan Raptors'
    end
  end
end
