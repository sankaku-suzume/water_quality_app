# == Schema Information
#
# Table name: appa_approvals
#
#  id         :bigint           not null, primary key
#  action     :integer
#  comment    :string
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  result_id  :bigint           not null
#
# Indexes
#
#  index_appa_approvals_on_result_id  (result_id)
#
class Approval < ApplicationRecord
  belongs_to :result

  validates :comment, length: { maximum: 100 }

  enum action: {
    requested: 0,
    approved: 1,
    rejected: 2
  }
end
