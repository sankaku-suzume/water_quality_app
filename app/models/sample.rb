# == Schema Information
#
# Table name: samples
#
#  id            :bigint           not null, primary key
#  inspector     :string
#  location      :string
#  remarks       :text
#  sampling_date :date             not null
#  sampling_time :time             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  plant_id      :bigint           not null
#
# Indexes
#
#  index_samples_on_plant_id  (plant_id)
#
class Sample < ApplicationRecord
  belongs_to :plant

  validates :sampling_date, presence: true
  validates :sampling_time, presence: true
  validates :location, length: { maximum: 50 }
  validates :inspector, length: { maximum: 20 }
  validates :remarks, length: { maximum: 400 }
end
