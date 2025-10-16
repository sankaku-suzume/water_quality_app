FactoryBot.define do
  factory :plant do
    name { Faker::Lorem.characters(number: 10) }
  end
end