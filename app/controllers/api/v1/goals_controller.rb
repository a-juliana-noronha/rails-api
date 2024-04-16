class Api::V1::GoalsController < ApplicationController
  before_action :authorize_request
  before_action :find_goal, except: %i[create index]

  # GET /goals
  def index
    @goals = Goal.where(filter_params)
    render json: @goals, each_serializer: GoalSerializer, params: params[:include]
  end


  # GET /goals/{id}
  def show
    render json: @goal, serializer: GoalSerializer, params: params[:include]
  end
  

  # POST /goals
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = @current_user.id

    if @goal.save
      render json: @goal, status: :created
    else
      render json: { errors: @goal.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /goals/{id}
  def update
    unless @goal.update(goal_params)
      render json: { errors: @goal.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /goals/{id}
  def destroy
    @goal.destroy
  end

  private

  def find_goal
    @goal = Goal.find_by_id!(params[:id])
    if !@goal
      ActiveRecord::RecordNotFound
    end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Meta não encontrada' }, status: :not_found
  end

  def goal_params
    params.permit(
      :name, :color, :icon, :amount, :due_date, :status
    )
  end

  def is_admin
    @current_user.role == 'admin'
  end

  def is_goal_owner
    is_admin || @goal.user_id == @current_user.id
  end

  def filter_params
    permitted_params = params.permit!.except(:controller, :action, :include)    
    !is_admin ? permitted_params.merge(user_id: @current_user.id) : permitted_params
  end
  
end
