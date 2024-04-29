class Api::V1::DashboardController < ApplicationController
  before_action :authorize_request

  # GET /dashboard
  def index
    @goals = Goal.all
    render json: @goals, each_serializer: GoalSerializer, params: params[:include]
  end

  private

  def is_admin
    @current_user.role == 'admin'
  end
  
end
