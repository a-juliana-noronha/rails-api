class Api::V1::AccountsController < ApplicationController
  before_action :authorize_request
  before_action :find_account, except: %i[create index]

  # GET /accounts
  def index
    @accounts = Account.all
    render json: @accounts, each_serializer: AccountSerializer, params: params[:include]
  end


  # GET /accounts/{id}
  def show
    render json: @account, serializer: AccountSerializer, params: params[:include]
  end
  

  # POST /accounts
  def create
    @account = Account.new(account_params)
    @account.user_id = @current_user.id

    unless @account.save
      render json: { errors: @account.errors.full_messages },
             status: :unprocessable_entity
    end

    update_default()

    render json: @account, serializer: AccountSerializer, params: params[:include], status: :created
  end

  # PUT /accounts/{id}
  def update
    unless @account.update(account_params)
      render json: { errors: @account.errors.full_messages },
             status: :unprocessable_entity
    end

    update_default()
  end

  # DELETE /accounts/{id}
  def destroy
    @account.destroy
  end

  private

  def find_account
    @account = Account.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Conta não encontrada' }, status: :not_found
  end

  def update_default
    if account_params[:is_default]
      @account.user.accounts.where.not(id: @account.id).update_all(is_default: false)
    end
  end

  def is_account_owner
    is_admin || @account.user_id == @current_user.id
  end

  def account_params
    params.permit(
      :name, :icon, :color, :account_type, :is_default, :status
    )
  end

  def filter_params
    permitted_params = params.permit!.except(:controller, :action, :include)    
    !is_admin ? permitted_params.merge(user_id: @current_user.id) : permitted_params
  end
end
