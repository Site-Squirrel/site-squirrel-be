class Api::V1::Users::TripsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: UserSerializer.new(user), status: 200
  end
end
