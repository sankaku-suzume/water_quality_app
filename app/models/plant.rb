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
  
end
