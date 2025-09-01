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
  validates :standard_max, numericality: { allow_nil: true }
  validates :standard_min, numericality: { allow_nil: true }
  validates :detection_limit, numericality: { allow_nil: true }
  validates :sort_order, numericality: { only_integer: true, allow_nil: true }
end
