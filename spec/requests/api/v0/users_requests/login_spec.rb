require 'rails_helper'

RSpec.describe "Create users, email, password ", type: :request do
  describe "POST /api/v0/sessions" do
    it 'valid credentials are sent, then has response' do
      user = create(:user, email: 'test@email.com', password: 'password', password_confirmation: 'password')
      valid_session_params = { email: user.email, password: user.password }

      post '/api/v0/sessions', params: valid_session_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to have_key(:data)
      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('users')
      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_a(String)
      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to have_key(:email)
      expect(data[:data][:attributes][:email]).to eq('test@email.com')
      expect(data[:data][:attributes]).to have_key(:api_key)
      expect(data[:data][:attributes][:api_key]).to be_a(String)
    end

    it 'returns error for invalid credentials, wrong email, same message for wrong email or password' do
      user = create(:user, email: 'test@email.com', password: 'password', password_confirmation: 'password')
      invalid_session_params = { email: 'wrong@email.com', password: user.password }
      
      post '/api/v0/sessions', params: invalid_session_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).not_to be_successful
      expect(response.status).to eq(401)

      errors = JSON.parse(response.body, symbolize_names: true)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors].first).to include('Invalid credentials')
    end

    it 'returns error for invalid credentials, wrong email, same message for wrong email or password' do
      user = create(:user, email: 'test@email.com', password: 'password', password_confirmation: 'password')
      invalid_session_params = { email: user.email, password: 'WrongPassword'}
      
      post '/api/v0/sessions', params: invalid_session_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).not_to be_successful
      expect(response.status).to eq(401)

      errors = JSON.parse(response.body, symbolize_names: true)
      expect(errors).to have_key(:errors)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors].first).to include('Invalid credentials')
    end
  end
end
