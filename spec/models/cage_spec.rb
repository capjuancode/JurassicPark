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

  describe 'Instance Methods' do
    let(:cage_with_vegan_dino) { create(:cage, :with_dino_vegan) }

    context "#current_diet check's all Dinos diet and make sure they are all the same" do
      it 'carnivore' do
        expect(cage_with_dino.current_diet).to eq 'carnivore'
      end

      it 'herbivore' do
        expect(cage_with_vegan_dino.current_diet).to eq 'herbivore'
      end
    end

    context "#same_species_type check's all Dinos species and make sure they are all the same" do
      it "works with herbivore" do
        expect(cage_with_vegan_dino.same_species_type).to eq 'Vegan Raptors'
      end
    end

    context "#full? check's cage" do
      it "is full" do
        expect(cage_with_dino.full?).to eq true
      end

      it "is not full" do
        cage_with_dino.dinos.first.delete
        expect(cage_with_dino.reload.full?).to eq false
      end
    end
  end

  describe '#Searchable' do
    before { cage_with_dino }

    context 'by name' do
      it 'with result' do
        expect(Cage.search({ name: cage_with_dino.name }).count).to eq 1
      end

      it 'without result' do
        expect(Cage.search({ name: 'cage' }).count).to eq 0
      end
    end

    context 'by status' do
      it 'with result' do
        expect(Cage.search({ status: cage_with_dino.status }).count).to eq 1
      end

      it 'without result' do
        expect(Cage.search({ status: 'down' }).count).to eq 0
      end
    end

    context 'by diet' do
      it 'with result' do
        expect(Cage.search({ diet: cage_with_dino.current_diet.to_s }).count).to eq 1
      end

      it 'without result' do
        expect(Cage.search({ name: 'carnivore' }).count).to eq 0
      end
    end

    context 'multiple query' do
      it 'with result' do
        expect(Cage.search({ status: cage_with_dino.status, diet: cage_with_dino.current_diet.to_s }).count).to eq 1
      end
    end
  end
end
