class Api::V1::Users::TripsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: UserSerializer.new(user), status: 200
  end

  def create
    trip = Trip.new(trip_params)
    if trip.save! 
      date = DateTime.parse(trip.start_date).to_date
      trip.number_nights.times do
        ReservationDay.create!(date: date.to_s, trip_id: trip.id)
        date += 1.days 
      end
      render json: TripSerializer.new(trip), status: 201
    else
      render json: ErrorSerializer.new(error).render_invalid_response, status: 400
    end
  end


  private

  def trip_params
    params.permit(:name, :vehicle_length, :tent_site_ok, :start_date, :number_nights, :user_id, :campground_location, :campground_id)
  end
end