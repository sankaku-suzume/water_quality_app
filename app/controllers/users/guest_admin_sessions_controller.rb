class Users::GuestAdminSessionsController < ApplicationController
  
  def create
    guest_admin_user = User.find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲスト管理者'
      user.admin = true
    end
    sign_in guest_admin_user
    redirect_to root_path, notice: 'ゲストユーザー(管理者)としてログインしました'
  end
end