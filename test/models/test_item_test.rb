# == Schema Information
#
# Table name: test_items
#
#  id              :bigint           not null, primary key
#  detection_limit :float
#  name            :string           not null
#  standard_max    :float
#  standard_min    :float
#  unit            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class TestItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
