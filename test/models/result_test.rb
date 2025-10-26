# == Schema Information
#
# Table name: appa_results
#
#  id           :bigint           not null, primary key
#  value        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sample_id    :bigint           not null
#  test_item_id :bigint           not null
#
# Indexes
#
#  index_appa_results_on_sample_id     (sample_id)
#  index_appa_results_on_test_item_id  (test_item_id)
#
require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
