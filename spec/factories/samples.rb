FactoryBot.define do
  factory :sample do
    sampling_date { Faker::Date.backward(days: 14) }
    sampling_time { Time.zone.parse("08:30") }
  end
end
