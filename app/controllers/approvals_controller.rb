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
    when 'approved'
      @approval.action = 'approved'
    when 'rejected'
      @approval.action = 'rejected'
    end

    if @approval.save
      redirect_to plant_sample_path(@result.sample.plant, @result.sample), notice: '承認依頼しました'
    else
      flash.now[:error] = '承認依頼できませんでした'
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