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
      flash.now.notice = '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now.notice = '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    flash.now.notice = '削除しました'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end
end
