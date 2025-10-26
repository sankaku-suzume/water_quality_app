# == Schema Information
#
# Table name: appa_samples
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
#  index_appa_samples_on_plant_id  (plant_id)
#
require 'test_helper'

class SampleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
