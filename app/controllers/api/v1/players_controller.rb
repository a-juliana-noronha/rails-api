class Api::V1::PlayersController < ApplicationController
  before_action :authorize_request
  before_action :find_player, except: %i[create create_bulk index]

  # GET /players
  def index
    @players = Player.where(filter_params)
    render json: @players, each_serializer: PlayerSerializer, params: params[:include]
  end


  # GET /players/{id}
  def show
    render json: @player, serializer: PlayerSerializer, params: params[:include]
  end
  

  # POST /players
  def create
    @player = Player.new(player_params)
    @player.user_id = @current_user.id

    if @player.save
      render json: @player, status: :created
    else
      render json: { errors: @player.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  # PUT /players/{id}
  def update
    unless @player.update(player_params)
      render json: { errors: @player.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /players/{id}
  def destroy
    @player.destroy
  end

  private

  def find_player
    @player = Player.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Player not found' }, status: :not_found
  end

  def player_params
    params.permit(
      :name, :email, :phone, :birthdate, :team_id, :group_id, :status
    )
  end

  def filter_params
    params.permit!.except(:controller, :action, :include)
  end
end
