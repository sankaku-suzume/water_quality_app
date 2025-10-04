class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(Arel.sql('name COLLATE "japanese"'))
  end
end