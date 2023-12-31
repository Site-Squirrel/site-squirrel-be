class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(params[:password])
      render json: UserSerializer.new(user), status: 200
    else
      render json: ErrorSerializer.new('Invalid email/password').invalid_request, status: 401
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
