require "rails_helper"

RSpec.describe "Sessions" do
  describe "Sessions Create" do
    it "authenticates a user and returns the user object if successful" do
      user_1 = create(:user, email: "test@example.com", password: "password")
      data_keys = [:id, :type, :attributes]
      attribute_keys = [:name, :email, :phone, :role]
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {

        'email': 'test@example.com',
        'password': 'password'
      }
      post "/api/v1/sessions", headers:, params: JSON.generate(body)
  
      user = JSON.parse(response.body, symbolize_names: true)
     
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(user[:data].keys).to eq(data_keys)
      expect(user[:data][:attributes].keys).to eq(attribute_keys)
      expect(user[:data][:type]).to eq('user')
      expect(user[:data][:attributes][:name]).to eq(user_1.name)
      expect(user[:data][:attributes][:email]).to eq(user_1.email)
      expect(user[:data][:attributes][:phone]).to eq(user_1.phone)
      expect(user[:data][:attributes][:role]).to eq(0)
    end

    it "renders an error message if authentication is unsuccessful due to an incorrect password" do
      user = create(:user, email: "test@example.com", password: "password")
      error_keys = %i[status title detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {
        'email': 'test@example.com',
        'password': 'passwor'
              }

      post "/api/v1/sessions", headers:, params: JSON.generate(body)
  
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_a(Array)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:status]).to eq('400')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq("Invalid email/password")
    end

    it "renders an error message if authentication is unsuccessful due to an incorrect email" do
      user = create(:user, email: "test@example.com", password: "password")
      error_keys = %i[status title detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {
        'email': 'tes@example.com',
        'password': 'password'
              }
              
      post "/api/v1/sessions", headers:, params: JSON.generate(body)
      
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_a(Array)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:status]).to eq('400')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq("Invalid email/password")
    end
  end
end