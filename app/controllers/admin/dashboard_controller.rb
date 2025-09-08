class Admin::DashboardController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def index
    @competitions_count = Competition.count
    @recent_competitions = Competition.order(created_at: :desc).limit(5)
  end
end
