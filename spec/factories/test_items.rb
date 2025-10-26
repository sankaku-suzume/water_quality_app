# == Schema Information
#
# Table name: appa_test_items
#
#  id              :bigint           not null, primary key
#  detection_limit :float
#  name            :string           not null
#  sort_order      :integer
#  standard_max    :float
#  standard_min    :float
#  unit            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :test_item do
    name { Faker::Lorem.characters(number: 10) }
  end
end
