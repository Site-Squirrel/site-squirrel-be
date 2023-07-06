class Api::V1::UsersController < ApplicationController
  def create
    if params[:password_digest] == params[:password_confirmation]
      user = User.new(user_params)
      user.save!
      render json: UserSerializer.new(user), status: 201
    else
      render json: ErrorSerializer.new('Passwords do not match').invalid_request, status: 400
    end
  end

  def update
    user = User.find(params[:id])
    render json: UserSerializer.new(user), status: 200 if user.update!(user_params)
  end

  def destroy
    user = User.find(params[:id])
    render json: DestroySerializer.new("Record successfully destroyed").destroyed_successfully, status: 200 if user.destroy!
  end

  private

  def user_params
    params.permit(:email, :name, :password_digest, :phone)
  end
end
