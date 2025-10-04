class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(Arel.sql('name COLLATE "japanese"'))
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(@user), notice: '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end
end