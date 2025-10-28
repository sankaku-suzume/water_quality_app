class Users::GuestSessionsController < ApplicationController
  
  def create
    guest_user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
    end
    sign_in guest_user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
  end
end