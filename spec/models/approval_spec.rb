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
require 'rails_helper'

RSpec.describe Approval, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
