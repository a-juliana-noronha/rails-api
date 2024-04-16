class Api::V1::CreditCardsController < ApplicationController
  before_action :authorize_request
  before_action :find_credit_card, except: %i[create index]

  # GET /credit_cards
  def index
    @credit_cards = CreditCard.all
    render json: @credit_cards, each_serializer: CreditCardSerializer, params: params[:include]
  end


  # GET /credit_cards/{id}
  def show
    render json: @credit_card, serializer: CreditCardSerializer, params: params[:include]
  end
  

  # POST /credit_cards
  def create
    @credit_card = CreditCard.new(credit_card_params)
    @credit_card.user_id = @current_user.id

    if @credit_card.save
      render json: @credit_card, serializer: CreditCardSerializer, params: params[:include], status: :created
    else
      render json: { errors: @credit_card.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /credit_cards/{id}
  def update
    unless @credit_card.update(credit_card_params)
      render json: { errors: @credit_card.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /credit_cards/{id}
  def destroy
    @credit_card.destroy
  end

  private

  def find_credit_card
    @credit_card = CreditCard.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Cartão não encontrado' }, status: :not_found
  end

  def is_credit_card_owner
    is_admin || @credit_card.user_id == @current_user.id
  end

  def credit_card_params
    params.permit(
      :name, :issuer, :icon, :color, :limit, :closing_date, :due_date, :status
    )
  end

  def filter_params
    permitted_params = params.permit!.except(:controller, :action, :include)    
    !is_admin ? permitted_params.merge(user_id: @current_user.id) : permitted_params
  end
end
