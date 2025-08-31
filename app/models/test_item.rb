# == Schema Information
#
# Table name: test_items
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
class TestItem < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 20 }
end
