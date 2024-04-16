class Api::V1::AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if !@user
      json_response({ error: 'Usuário não encontrado' }, 404)
    elsif @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token }, status: :ok
    else
      json_response({ error: 'Senha incorreta' }, 401)
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

end