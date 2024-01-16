class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
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
