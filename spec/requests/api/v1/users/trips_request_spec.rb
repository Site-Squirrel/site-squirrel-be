require 'rails_helper'

RSpec.describe "User Trips Request" do
  describe "User Trips Index" do
    it "can render all of a user's trips" do
      data_keys = %i[id type attributes]
      attribute_keys = %i[name email phone role trips]
      trip_attribute_keys = [:name, :campground_id, :vehicle_length, :tent_site_ok, :campground_location, :start_date, :number_nights]
      user_1 = create(:user)
      trip_1 = create(:trip, user_id: user_1.id)
      trip_2 = create(:trip, user_id: user_1.id)
      trip_3 = create(:trip, user_id: user_1.id)
    
      get "/api/v1/users/#{user_1.id}/trips"

      user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(user[:data].keys).to eq(data_keys)
      expect(user[:data][:attributes].keys).to eq(attribute_keys)
      expect(user[:data][:type]).to eq('user')
      expect(user[:data][:attributes][:name]).to eq(user_1.name)
      expect(user[:data][:attributes][:email]).to eq(user_1.email)
      expect(user[:data][:attributes][:phone]).to eq(user_1.phone)
      expect(user[:data][:attributes][:role]).to eq(user_1.role)
      user[:data][:attributes][:trips][:data].each do |trip|
        expect(trip.keys).to eq(data_keys)
        expect(trip[:attributes].keys).to eq(trip_attribute_keys)
      end
      expect(user[:data][:attributes][:trips][:data].first[:attributes][:name]).to eq(trip_1.name)
      expect(user[:data][:attributes][:trips][:data].first[:attributes][:campground_id]).to eq(trip_1.campground_id)
      expect(user[:data][:attributes][:trips][:data].first[:attributes][:vehicle_length]).to eq(trip_1.vehicle_length)
      expect(user[:data][:attributes][:trips][:data].first[:attributes][:tent_site_ok]).to eq(trip_1.tent_site_ok)
      expect(user[:data][:attributes][:trips][:data].first[:attributes][:campground_location]).to eq(trip_1.campground_location)
      expect(user[:data][:attributes][:trips][:data].first[:attributes][:start_date]).to eq(trip_1.start_date)
      expect(user[:data][:attributes][:trips][:data].first[:attributes][:number_nights]).to eq(trip_1.number_nights)
    end

    it "can render a user with no trips" do
      data_keys = %i[id type attributes]
      attribute_keys = %i[name email phone role trips]
      user_1 = create(:user)
    
      get "/api/v1/users/#{user_1.id}/trips"

      user = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(user[:data].keys).to eq(data_keys)
      expect(user[:data][:attributes].keys).to eq(attribute_keys)
      expect(user[:data][:type]).to eq('user')
      expect(user[:data][:attributes][:name]).to eq(user_1.name)
      expect(user[:data][:attributes][:email]).to eq(user_1.email)
      expect(user[:data][:attributes][:phone]).to eq(user_1.phone)
      expect(user[:data][:attributes][:role]).to eq(user_1.role)
      expect(user[:data][:attributes][:trips][:data]).to eq([])
    end

    it "can render an error if the user is not found" do
      error_keys = %i[status title detail]
    
      get "/api/v1/users/15/trips"

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_a(Array)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:status]).to eq('400')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq("Couldn't find User with 'id'=15")
    end
  end
end