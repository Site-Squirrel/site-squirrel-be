require 'rails_helper'

RSpec.describe 'User Request Spec' do
  describe 'User Create' do
    it 'can create a new user and render the user object' do
      data_keys = %i[id type attributes]
      attribute_keys = %i[name email phone role]
      headers = { 'CONTENT_TYPE' => 'application/json' }
      body =  {

        'email': 'whatever@example.com',
        'password_digest': 'password',
        'password_confirmation': 'password',
        'phone': '5555555555',
        'name': 'Matt E'
      }

      expect(User.all.count).to eq(0)

      post '/api/v1/users', headers:, params: JSON.generate(body)

      user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(user[:data].keys).to eq(data_keys)
      expect(user[:data][:attributes].keys).to eq(attribute_keys)
      expect(user[:data][:type]).to eq('user')
      expect(user[:data][:attributes][:name]).to eq(body[:name])
      expect(user[:data][:attributes][:email]).to eq(body[:email])
      expect(user[:data][:attributes][:phone]).to eq(body[:phone])
      expect(user[:data][:attributes][:role]).to eq(0)
      expect(User.all.count).to eq(1)
    end

    it 'shows an error if creation is unsuccessful due to a missing field' do
      error_keys = %i[status title detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }
      body =  {

        'email': '',
        'password_digest': 'password',
        'password_confirmation': 'password',
        'phone': '5555555555',
        'name': 'Matt E'
      }

      post '/api/v1/users', headers:, params: JSON.generate(body)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_a(Array)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:status]).to eq('400')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq("Validation failed: Email can't be blank")
    end

    it 'shows an error if creation is unsuccessful due a non-unique email' do
      error_keys = %i[status title detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }
      user = create(:user, email: 'user@example.com')
      body = {

        'email': user.email,
        'password_digest': 'password',
        'password_confirmation': 'password',
        'phone': '5555555555',
        'name': 'Matt E'
      }

      post '/api/v1/users', headers:, params: JSON.generate(body)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_a(Array)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:status]).to eq('400')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq('Validation failed: Email has already been taken')
    end

    it 'shows an error if creation is unsuccessful due to passwords not matching' do
      error_keys = %i[status title detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }
      user = create(:user, email: 'user@example.com')
      body = {

        'email': 'user@example.com',
        'password_digest': 'password',
        'password_confirmation': 'passwor',
        'phone': '5555555555',
        'name': 'Matt E'
      }

      post '/api/v1/users', headers:, params: JSON.generate(body)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_a(Array)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:status]).to eq('400')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq('Passwords do not match')
    end
  end

  describe "User Edit" do
    it "can edit a user's attributes and return the updated user info" do
      data_keys = %i[id type attributes]
      attribute_keys = %i[name email phone role]
      user_1 = create(:user, email: "test@example.com")
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      user_params = {
        email: "test1@xample.com"
      }

      patch "/api/v1/users/#{user_1.id}", headers:, params: JSON.generate(user_params)
      user = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(user[:data].keys).to eq(data_keys)
      expect(user[:data][:attributes].keys).to eq(attribute_keys)
      expect(user[:data][:type]).to eq('user')
      expect(user[:data][:attributes][:email]).to_not eq(user_1.email)
      expect(user[:data][:attributes][:email]).to eq(user_params[:email])
    end

    it "renders a serialized error if the update is unsuccessful due to missing inputs" do
      user_1 = create(:user, email: "test@example.com")
      error_keys = %i[status title detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      user_params = {
        email: ""
      }

      patch "/api/v1/users/#{user_1.id}", headers:, params: JSON.generate(user_params)
      error = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_a(Array)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:status]).to eq('400')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq("Validation failed: Email can't be blank")
    end

    it "renders a serialized error if the update is unsuccessful due to the user not being found" do
      user_1 = create(:user, email: "test@example.com")
      error_keys = %i[status title detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      user_params = {
        email: "test1@example.com"
      }

      patch "/api/v1/users/15", headers:, params: JSON.generate(user_params)
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

  describe "User delete" do
    it "can destroy a user and render a successful message" do
      user = create(:user)
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      expect(User.count).to eq(1)

      delete "/api/v1/users/#{user.id}", headers: headers

      message = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(User.count).to eq(0)
      expect(message[:message]).to eq("Record successfully destroyed")
      expect{User.find(user.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "renders a serialized error if the destroy action is unsuccessful" do
      user = create(:user)
      error_keys = %i[status title detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      expect(User.count).to eq(1)

      delete "/api/v1/users/15", headers: headers

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
