FactoryBot.define do
  factory :dino do
    name { "MyString" }
    association :cage, factory: :cage
    association :species, factory: :species

    trait :herbivore do
      association :species, factory: :species, diet: :herbivore, name: 'Vegan Raptors'
    end
  end
end
