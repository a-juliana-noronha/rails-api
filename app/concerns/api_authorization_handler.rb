module ApiAuthorizationHandler
  extend ActiveSupport::Concern

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      puts @decoded
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      json_response({ error: 'Usuário não encontrado' }, 404)
      # render_error_response(errors: e.message, status: 401)
    rescue JWT::DecodeError => e
      json_response({ error: 'Credenciais inválidas' }, 401)
      # render_error_response(errors: e.message, status: 401)
    end
  end
end