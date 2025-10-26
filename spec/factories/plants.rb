# == Schema Information
#
# Table name: appa_plants
#
#  id         :bigint           not null, primary key
#  location   :string
#  name       :string           not null
#  remarks    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
