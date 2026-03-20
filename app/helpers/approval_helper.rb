module ApprovalHelper
  def action_label(approval)
    case approval.action
    when 'requested' then '承認依頼'
    when 'approved' then '承認'
    when 'rejected' then '差戻'
    end
  end
end
