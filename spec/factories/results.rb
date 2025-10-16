FactoryBot.define do
  factory :result do
    value { Faker::Number.decimal(l_digits: 2) }
  end
end
