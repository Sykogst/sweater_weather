require 'rails_helper'

RSpec.describe "Create users, email, password ", type: :request do
  describe "POST /api/v0/users" do
    it 'creates new user with valid parameters' do
      user = build(:user)
      valid_new_user_params = {
        email: user.email,
        password: user.password,
        password_confirmation: user.password_confirmation
      }

      post '/api/v0/users', params: valid_new_user_params, headers: { 'Content_Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to be_successful
      expect(response.status).to eq(201)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to have_key(:data)
      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('user')
      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_a(String)
      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to have_key(:email)
      expect(data[:data][:attributes][:email]).to eq(user.email)
      expect(data[:data][:attributes]).to have_key(:api_key)
      expect(data[:data][:attributes][:api_key]).to be_a(String)
    end
  
    it 'returns error for invalid parameters, missing email' do
      invalid_new_user_params = {
        password: 'Password123',
        password_confirmation: 'Password123'
      }

      post '/api/v0/users', params: invalid_new_user_params, headers: { 'Content_Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).not_to be_successful
      expect(response.status).to eq(422)

      errors = JSON.parse(response.body, symbolize_names: true)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors].first[:detail]).to include("Email can't be blank")
    end

    it 'returns error for invalid parameters, non matching password' do
      invalid_new_user_params = {
        email: 'stran@gmail.com',
        password: 'Password123',
        password_confirmation: 'DoesNotMatch'
      }

      post '/api/v0/users', params: invalid_new_user_params, headers: { 'Content_Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).not_to be_successful
      expect(response.status).to eq(422)

      errors = JSON.parse(response.body, symbolize_names: true)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors].first[:detail]).to include("Password confirmation doesn't match Password")
    end

    it 'returns error for invalid parameters, email taken' do
      invalid_new_user_params = {
        email: 'stran@gmail.com',
        password: 'Password123',
        password_confirmation: 'Password123'
      }

      post '/api/v0/users', params: invalid_new_user_params, headers: { 'Content_Type' => 'application/json', 'Accept' => 'application/json' }
      post '/api/v0/users', params: invalid_new_user_params, headers: { 'Content_Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(422)

      errors = JSON.parse(response.body, symbolize_names: true)
      expect(errors[:errors]).to be_an(Array)
      expect(errors[:errors].first[:detail]).to include("Email has already been taken")
    end
  end
end
