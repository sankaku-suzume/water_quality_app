class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(Arel.sql('name COLLATE "japanese"'))
  end

  def new
    @user = User.build
  end

  def create
    @user = User.build(user_params)
    if @user.save
      redirect_to admin_users_path, notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    redirect_to admin_users_path, status: :see_other, notice: '削除しました'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end
end
