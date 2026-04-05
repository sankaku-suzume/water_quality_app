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
class Result < ApplicationRecord
  belongs_to :sample
  belongs_to :test_item
  has_many :approvals, dependent: :destroy

  validates :value, numericality: { allow_nil: true }

  def latest_approval
    approvals.order(created_at: :desc).first
  end

  def approved?
    latest_approval&.approved?
  end
end
