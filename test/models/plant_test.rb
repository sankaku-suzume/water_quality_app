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
require 'test_helper'

class PlantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
