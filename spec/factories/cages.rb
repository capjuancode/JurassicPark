FactoryBot.define do
  factory :cage do
    name { 'MyString' }
    max_capacity { 3 }
    status { :active }

    trait :with_dino do
      after(:create) do |cage|
        create_list(:dino, 3, cage: cage)
      end
    end

    trait :with_dino_vegan do
      after(:create) do |cage|
        create_list(:dino, 3, :herbivore, cage: cage)
      end
    end
  end
end
