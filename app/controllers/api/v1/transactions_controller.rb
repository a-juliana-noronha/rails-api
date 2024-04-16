class Api::V1::TransactionsController < ApplicationController
  before_action :authorize_request
  before_action :find_transaction, except: %i[create index]

  # GET /transactions
  def index
    puts filter_params
    @transactions = Transaction.where(filter_params)
    render json: @transactions, each_serializer: TransactionSerializer, params: params[:include]
  end


  # GET /transactions/{id}
  def show
    render json: @transaction, serializer: TransactionSerializer, params: params[:include]
  end
  

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = @current_user.id

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: { errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /transactions/{id}
  def update
    unless @transaction.update(transaction_params)
      render json: { errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /transactions/{id}
  def destroy
    @transaction.destroy
  end

  private

  def find_transaction
    @transaction = Transaction.find_by_id!(params[:id])
    if !@transaction
      ActiveRecord::RecordNotFound
    end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Transação não encontrada' }, status: :not_found
  end

  def transaction_params
    params.permit(
      :name, :amount, :date, :accrual_date, :transaction_type, :reminder, :status, :account_id, :credit_card_id, :category_id
    )
  end

  def is_admin
    @current_user.role == 'admin'
  end

  def is_transaction_owner
    is_admin || @transaction.user_id == @current_user.id
  end

  def filter_params
    permitted_params = params.permit!.except(:controller, :action, :include, :from, :to)    
    !is_admin ? permitted_params.merge(user_id: @current_user.id) : permitted_params
    
    permitted_params = permitted_params.merge(date: params[:from]..params[:to])
  end
  
end
