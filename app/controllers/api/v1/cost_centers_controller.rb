class Api::V1::CostCentersController < ApplicationController
  before_action :authorize_request
  before_action :find_cost_center, except: %i[create index]

  # GET /cost_centers
  def index
    @cost_centers = CostCenter.where(filter_params)
    render json: @cost_centers, each_serializer: CostCenterSerializer, params: params[:include]
  end


  # GET /cost_centers/{id}
  def show
    render json: @cost_center, status: :ok
  end
  

  # POST /cost_centers
  def create
    @cost_center = CostCenter.new(cost_center_params)
    @cost_center.user_id = @current_user.id

    if @cost_center.save
      render json: @cost_center, status: :created
    else
      render json: { errors: @cost_center.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /cost_centers/{id}
  def update
    unless @cost_center.update(cost_center_params)
      render json: { errors: @cost_center.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /cost_centers/{id}
  def destroy
    @cost_center.destroy
  end

  private

  def find_cost_center
    @cost_center = CostCenter.find_by_id!(params[:id])

  if !@cost_center || !is_cost_center_owner
      ActiveRecord::RecordNotFound
    end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Centro de custo não encontrado' }, status: :not_found
  end

  def is_cost_center_owner
    is_admin || @cost_center.user_id == @current_user.id
  end

  def cost_center_params
    params.permit( :name, :description, :icon, :color, :monthly_limit, :status)
  end

  def filter_params
    permitted_params = params.permit!.except(:controller, :action, :include)    
    !is_admin ? permitted_params.merge(user_id: @current_user.id) : permitted_params
  end
  
end
