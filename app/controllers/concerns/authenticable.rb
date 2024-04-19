module Authenticable
  def authenticate_user!
    # Rails.logger.debug "Authorization Header: #{request.headers['Authorization']}"
    header = request.headers['Authorization']
    token = request.headers['Authorization']&.split(' ')&.last
    return if header.nil?
    decoded = decode_jwt(token)
    @current_user = User.find(decoded["id"]) if decoded
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    render json: { error: 'You need to sign in or sign up before continuing.' }, status: :unauthorized
  end

  private

  def decode_jwt(token)
    decoded = JWT.decode(token, Rails.application.credentials.jwt_secret_key, true, { algorithm: 'HS256' })
    decoded.first
  rescue JWT::DecodeError => e
    Rails.logger.debug "JWT Decode Error: #{e.message}"
    nil
  end
end
