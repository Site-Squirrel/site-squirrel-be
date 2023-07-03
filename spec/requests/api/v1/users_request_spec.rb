require 'rails_helper'

RSpec.describe 'User Request Spec' do
  describe 'User Create' do
    it 'can create a new user' do
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
end
