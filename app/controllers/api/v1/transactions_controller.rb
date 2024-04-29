class Api::V1::TransactionsController < ApplicationController
  before_action :authorize_request
  before_action :find_transaction, except: %i[create index]

  # GET /transactions
  def index
    @transactions = Transaction.where(filter_params)

    if params[:has_payment_plan]
      @transactions = @transactions.where.not(payment_plan_id: nil)
    end
    render json: @transactions, each_serializer: TransactionSerializer, params: params[:include]
  end

  # GET /transactions/{id}
  def show
    render json: @transaction, serializer: TransactionSerializer, params: params[:include]
  end

  # POST /transactions
  def create
    total_installments = transaction_params.delete(:total_installments).to_i
    amount = total_installments > 0 ? (transaction_params[:amount] / total_installments).round : transaction_params[:amount]
    
    transactions = []
    
    if total_installments > 1
      card = Card.where(id: transaction_params[:card_id]).first

      payment_plan = PaymentPlan.create(
        total_amount: transaction_params[:amount],
        total_installments: total_installments,
        user_id: @current_user.id,
        card_id: card.id,
        reminder: true,
        days: 30
      )

      total_installments.times do |i|
        current_installment = i + 1

        if Date.today.day >= card.closing_day
          date = (Date.today + (current_installment).months).change(day: card.due_day)
        else
          date = (Date.today + (i).months).change(day: card.due_day)
        end

        transaction = Transaction.new(transaction_params.except(:total_installments).merge(
          amount: amount,
          date: date,
          current_installment: current_installment,
          user_id: @current_user.id,
          payment_plan_id: payment_plan.id
        ))
    
        if transaction.save
          transactions << transaction
        else
          render json: { errors: transaction.errors.full_messages },
                 status: :unprocessable_entity
          return
        end
      end
    else
      transaction = Transaction.new(
        transaction_params.except(:total_installments).merge(
          user_id: @current_user.id
        )
      )
  
      if transaction.save
        transactions << transaction
      else
        render json: { errors: transaction.errors.full_messages },
                status: :unprocessable_entity
        return
      end
    end

    render json: transactions, each_serializer: TransactionSerializer, params: params[:include]
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
      :name, :amount, :date, :transaction_type, :total_installments, :status, :account_id, :card_id, :category_id, :reminder_id
    )
  end

  def is_admin
    @current_user.role == 'admin'
  end

  def is_transaction_owner
    is_admin || @transaction.user_id == @current_user.id
  end

  def filter_params
    permitted_params = params.permit!.except(:controller, :action, :include, :from, :to, :not, :has_payment_plan, :category_ids)

    if params[:category_ids].present?
      category_ids = params[:category_ids].split(",").map(&:to_i)
      permitted_params[:category_id] = category_ids
    end

    !is_admin ? permitted_params.merge(user_id: @current_user.id) : permitted_params
    
    permitted_params = permitted_params.merge(date: params[:from]..params[:to])
  end
  
end
