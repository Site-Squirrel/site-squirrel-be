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

  describe "User Trips create" do
    it "can create a new trip" do
      user_1 = create(:user)
      trip_keys = [:id, :type, :attributes]
      trip_attr_keys = [:name, :campground_id, :vehicle_length, :tent_site_ok, :campground_location, :start_date, :number_nights]
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {

        'name': 'My camping trip',
        'vehicle_length': '15',
        'tent_site_ok': true,
        'start_date': '2024/10/07',
        'number_nights': 2,
        'campground_id': '123456',
        'campground_location': '123213.23, 123232,12',
        'user_id': "#{user_1.id}"
              }

      expect(Trip.count).to eq(0) 
      expect(ReservationDay.count).to eq(0)       

      post "/api/v1/users/#{user_1.id}/trips", headers:, params: JSON.generate(body)
      
      trip = JSON.parse(response.body, symbolize_names: true)
       
      expect(Trip.count).to eq(1)
      expect(ReservationDay.count).to eq(2)
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(trip[:data].keys).to eq(trip_keys)
      expect(trip[:data][:attributes][:name]).to eq(body[:name])
      expect(trip[:data][:attributes][:campground_id]).to eq(body[:campground_id])
      expect(trip[:data][:attributes][:vehicle_length]).to eq(body[:vehicle_length])
      expect(trip[:data][:attributes][:tent_site_ok]).to eq(body[:tent_site_ok])
      expect(trip[:data][:attributes][:campground_location]).to eq(body[:campground_location])
      expect(trip[:data][:attributes][:start_date]).to eq(body[:start_date])
      expect(trip[:data][:attributes][:number_nights]).to eq(body[:number_nights])
    end

    it "renders an error if a required field is missing" do
      user_1 = create(:user)
      error_keys = %i[status title detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {

        'name': '',
        'vehicle_length': '15',
        'tent_site_ok': true,
        'start_date': '2024/10/07',
        'number_nights': 2,
        'campground_id': '123456',
        'campground_location': '123213.23, 123232,12',
        'user_id': "#{user_1.id}"
              }

      post "/api/v1/users/#{user_1.id}/trips", headers:, params: JSON.generate(body)
      
      error = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_a(Array)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:status]).to eq('400')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq("Validation failed: Name can't be blank")
    end
  end
end