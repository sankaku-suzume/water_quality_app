FactoryBot.define do
  factory :sample do
    sampling_date { Faker::Date.backward(days: 14) }
    sampling_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
