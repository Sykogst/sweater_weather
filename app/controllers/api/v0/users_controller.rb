class Api::V0::UsersController < ApplicationController
  def create
    begin
      user = User.new(user_params)
      user.save!

      render json: UserSerializer.new(user), status: :created
    rescue ActiveRecord::RecordInvalid => exception
      handle_error(exception)
    end
  end

  private 
  
  def user_params
    payload = JSON.parse(request.body.read, symbolize_names: true)
    ActionController::Parameters.new(payload).permit(:email, :password, :password_confirmation)
  end

  def handle_error(exception)
    case exception.message
    when 'Email has already been taken'
      render json: ErrorSerializer.new(ErrorMessage.new('Email has already been taken', 422)).error_json, status: :unprocessable_entity
    when "Password confirmation doesn't match Password"
      render json: ErrorSerializer.new(ErrorMessage.new("Password confirmation doesn't match Password", 422)).error_json, status: :unprocessable_entity
    else
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).error_json, status: :unprocessable_entity
    end
  end
end
