class DashboardController < ApplicationController
  layout 'dashboard'

  def index
    @dimension = params[:dimension] || 'year'
    @date_range = params[:date_range]
  end

  def team_members
  end

  def about
  end

  def predict
  end

  def dataset_info
  end
end
