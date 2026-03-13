class ApprovalsController < ApplicationController
  before_action :authenticate_user!

  def new
    @approval = @result.approvals.build
  end

  def create
    @approval = @result.approvals.build(approval_params, action: 0, user_id: current_user.id)
    if @approval.save
      redirect_to result_path(@result), notice: '承認依頼しました'
    else
      flash.now[:error] = '承認依頼できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def approval_params
    params.require(:approval).permit(:action, :user_name, :comment)
  end

  def set_result
    @result = Result.find(params[:result_id])
  end
end