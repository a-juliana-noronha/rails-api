class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index me]

  # GET /users
  def index
    @users = User.all()
    render json: @users, each_serializer: UserSerializer, params: params[:include]
  end

  # GET /users/me
  def me 
    render json: @current_user, status: :ok
  end

  # GET /users/{id}
  def show
    render json: @user, serializer: UserSerializer, params: params[:include]
  end
  

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end
  

  # PUT /users/{id}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{id}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :email, :phone, :password, :role, :status
    )
  end
end