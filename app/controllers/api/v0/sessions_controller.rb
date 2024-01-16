class Api::V0::SessionsController < ApplicationController
  def create
    payload = JSON.parse(request.body.read, symbolize_names: true)
    email = payload[:email]
    password = payload[:password]
    
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      render json: { data: { type: 'users', id: user.id.to_s, attributes: { email: user.email, api_key: user.api_key } } }, status: :ok
    else
      unauthorized_error
    end
  end

  private

  def unauthorized_error
    render json: { errors: ['Invalid credentials'] }, status: :unauthorized
  end
end
