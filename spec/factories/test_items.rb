FactoryBot.define do
  factory :test_item do
    name { Faker::Lorem.characters(number: 10) }
  end
end
