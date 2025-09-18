class DashboardController < ApplicationController
  def index
    @recent_samples = Sample.order(created_at: :desc).limit(5)
  end
end