class Api::V1::CardsController < ApplicationController
  before_action :authorize_request
  before_action :find_card, except: %i[create index]

  # GET /cards
  def index
    @cards = Card.all
    render json: @cards, each_serializer: CardSerializer, params: params[:include]
  end


  # GET /cards/{id}
  def show
    render json: @card, serializer: CardSerializer, params: params[:include]
  end
  

  # POST /cards
  def create
    @card = Card.new(card_params)
    @card.user_id = @current_user.id

    unless @card.save
      render json: { errors: @card.errors.full_messages },
             status: :unprocessable_entity
    end
    
    update_default()

    render json: @card, serializer: CardSerializer, params: params[:include], status: :created
  end

  # PUT /cards/{id}
  def update
    unless @card.update(card_params)
      render json: { errors: @card.errors.full_messages },
             status: :unprocessable_entity
    end

    update_default()
  end

  # DELETE /cards/{id}
  def destroy
    @card.destroy
  end

  private

  def find_card
    @card = Card.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Cartão não encontrado' }, status: :not_found
  end

  def update_default
    if card_params[:is_default]
      @card.user.cards.where.not(id: @card.id).update_all(is_default: false)
    end
  end

  def is_card_owner
    is_admin || @card.user_id == @current_user.id
  end

  def card_params
    params.permit(
      :name, :issuer, :icon, :color, :limit, :closing_day, :due_day, :is_default, :status
    )
  end

  def filter_params
    permitted_params = params.permit!.except(:controller, :action, :include)    
    !is_admin ? permitted_params.merge(user_id: @current_user.id) : permitted_params
  end
end
