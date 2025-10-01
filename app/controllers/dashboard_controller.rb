class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @recent_samples = Sample.order(created_at: :desc).limit(5)
  end
end
