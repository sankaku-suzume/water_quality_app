class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @recent_samples = Sample.order(sampling_date: :desc).limit(5)

    # 各result_idの最新のapprovalを取得
    latest_approvals = Approval.select('DISTINCT ON (result_id) *').order('result_id, created_at DESC')

    # latest_approvalsからrequestedのものだけを抽出
    @approvals_requested = Approval.select('latest_approvals.*').from("(#{latest_approvals.to_sql}) AS latest_approvals").where('latest_approvals.action = ?', 0)

    # latest_approvalsからrejectedのものだけを抽出
    @approvals_rejected = Approval.select('latest_approvals.*').from("(#{latest_approvals.to_sql}) AS latest_approvals").where('latest_approvals.action = ?', 2)
  end
end
