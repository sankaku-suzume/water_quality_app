# == Schema Information
#
# Table name: results
#
#  id           :bigint           not null, primary key
#  value        :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sample_id    :bigint           not null
#  test_item_id :bigint           not null
#
# Indexes
#
#  index_results_on_sample_id     (sample_id)
#  index_results_on_test_item_id  (test_item_id)
#
require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
