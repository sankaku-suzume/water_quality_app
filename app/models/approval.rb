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

  validate :check_creatable
  validate :check_previous_action

  enum action: {
    requested: 0,
    approved: 1,
    rejected: 2
  }

  private
    def check_creatable
      if result.approved?
        errors.add(:base, '承認済みです')
      end
    end

    def check_previous_action
      previous_approval = result.approvals.where.not(id: self.id).order(created_at: :desc).first

      if previous_approval.nil? && !self.requested?
        errors.add(:base, '承認依頼してください')
      elsif previous_approval&.requested? && self.requested?
        errors.add(:base, 'すでに承認依頼中です')
      elsif previous_approval&.rejected? && self.rejected?
        errors.add(:base, 'すでに差戻中です')
      end
    end
end
