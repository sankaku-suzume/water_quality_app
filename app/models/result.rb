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
class Result < ApplicationRecord
  belongs_to :sample
  belongs_to :test_item

  validates :value, numericality: { allow_nil: true }

  def average(results)
    values = set_values(results)
    values.sum.fdiv(results.length)
  end

  def minimum(results)
    values = set_values(results)
    values.min
  end

  def maximum(results)
    values = set_values(results)
    values.max
  end

  private
  def set_values(results)
    values = []
    results.each do |result|
      value = result.value
      values.push(value)
    end
    values
  end

end
