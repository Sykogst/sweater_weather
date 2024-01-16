class Api::V0::UsersController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :param_missing_error_response
  rescue_from ActiveRecord::RecordInvalid, with: :validation_error_response
  
  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  private 
  
  def user_params
    params.requre(:user).permit(:email, :password, :password_confirmation)
  end
end
