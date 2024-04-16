class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request
  before_action :find_category, except: %i[create index]

  # GET /categories
  def index
    @categories = Category.where(filter_params)
    render json: @categories, each_serializer: CategorySerializer, params: params[:include]
  end


  # GET /categories/{id}
  def show
    render json: @category, status: :ok
  end
  

  # POST /categories
  def create
    @category = Category.new(category_params)
    @category.user_id = @current_user.id

    if @category.save
      render json: @category, status: :created
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /categories/{id}
  def update
    unless @category.update(category_params)
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /categories/{id}
  def destroy
    @category.destroy
  end

  private

  def find_category
    @category = Category.find_by_id!(params[:id])

  if !@category || !is_category_owner
      ActiveRecord::RecordNotFound
    end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Categoria não encontrada' }, status: :not_found
  end

  def is_category_owner
    is_admin || @category.user_id == @current_user.id
  end

  def category_params
    params.permit( :name, :description, :icon, :color, :monthly_limit, :status)
  end

  def filter_params
    permitted_params = params.permit!.except(:controller, :action, :include)    
    !is_admin ? permitted_params.merge(user_id: @current_user.id) : permitted_params
  end
  
end
