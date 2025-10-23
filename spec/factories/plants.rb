FactoryBot.define do
  factory :plant do
    name { Faker::Lorem.characters(number: 10) }

    trait :with_sample do
      after :create do |plant|
        create(:sample, plant: plant)
      end
    end
  end
end
