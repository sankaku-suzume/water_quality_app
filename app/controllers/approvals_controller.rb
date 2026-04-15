class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_result, only: [ :new, :create ]
  before_action :result_approved?, only: [ :new, :create ]

  def index
    # 各result_idの最新のapprovalを取得
    latest_approvals = Approval.select('DISTINCT ON (result_id) *').order('result_id, created_at DESC')

    # latest_approvalsからrequestedのものだけを抽出
    @approvals_requested = Approval.select('latest_approvals.*').from("(#{latest_approvals.to_sql}) AS latest_approvals").where('latest_approvals.action = ?', 0).order('latest_approvals.created_at DESC')

    # latest_approvalsからrejectedのものだけを抽出
    @approvals_rejected = Approval.select('latest_approvals.*').from("(#{latest_approvals.to_sql}) AS latest_approvals").where('latest_approvals.action = ?', 2).order('latest_approvals.created_at DESC')
  end

  def new
    @approval = @result.approvals.build

    # submitボタンを前のレコードの値で出し分けるための判定用
    @previous_approval = @result.approvals.order(created_at: :desc).first
  end

  def create
    @approval = @result.approvals.build(approval_params)

    case params[:submit_type]
    when 'requested'
      @approval.action = 'requested'
      message_notice = '承認依頼しました'
      message_error = '承認依頼できませんでした'
    when 'approved'
      @approval.action = 'approved'
      message_notice = '承認しました'
      message_error = '承認できませんでした'
    when 'rejected'
      @approval.action = 'rejected'
      message_notice = '差戻しました'
      message_error = '差戻しできませんでした'
    end

    if @approval.save
      flash.now.notice = message_notice
    else
      flash.now[:error] = message_error
      render :new, status: :unprocessable_entity
    end
  end

  private
  def approval_params
    params.require(:approval).permit(:action, :comment, :submit_type).merge(user_name: current_user.name)
  end

  def set_result
    @result = Result.find(params[:result_id])
  end

  def result_approved?
    set_result
    if @result.approved?
      redirect_to plant_sample_path(params[:plant_id], params[:sample_id]),  notice: '承認済みです'
    end
  end
end
