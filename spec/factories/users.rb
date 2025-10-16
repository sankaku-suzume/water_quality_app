FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end
end
