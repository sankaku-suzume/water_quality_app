# == Schema Information
#
# Table name: plants
#
#  id         :bigint           not null, primary key
#  location   :string
#  name       :string           not null
#  remarks    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Plant < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 50 }

  validates :location, length: { maximum: 50 }

  validates :remarks, length: { maximum: 400 }
end
