class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_result

  def new
    @approval = @result.approvals.build
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
end