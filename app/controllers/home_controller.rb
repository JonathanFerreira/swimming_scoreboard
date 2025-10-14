class HomeController < ApplicationController
  def index
    @competitions = Competition.all.order(:event_initial_date)
  end
end
