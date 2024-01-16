require 'rails_helper'

RSpec.describe 'Road trip based on json payload in body', type: :request do
  describe 'POST /api/v0/road_trip', :vcr do
    xit 'creates a new road trip and returns the expected response' do
      user = create(:user)
      valid_payload = {
        origin: 'Cincinnati,OH',
        destination: 'Chicago,IL',
        api_key: user.api_key
      }

      post '/api/v0/road_trip', params: valid_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to have_key(:data)
      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_nil
      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('road_trip')
      expect(data[:data]).to have_key(:attributes)

      attributes = data[:data][:attributes]
      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to be_a(String)
      expect(attributes).to have_key(:end_city)
      expect(attributes[:end_city]).to be_a(String)
      expect(attributes).to have_key(:travel_time)
      expect(attributes[:travel_time]).to be_a(String)
      expect(attributes).to have_key(:weather_at_eta)
      expect(attributes[:weather_at_eta]).to be_a(Hash)

      destination_weather = data[:data][:attributes][:weather_at_eta]
      expect(destination_weather).to have_key(:datetime)
      expect(destination_weather[:datetime]).to be_a(String)
      expect(destination_weather).to have_key(:temperature)
      expect(destination_weather[:temperature]).to be_a(Float)
      expect(destination_weather).to have_key(:condition)
      expect(destination_weather[:condition]).to be_a(String)
    end

    xit 'returns 401 Unauthorized, missing API Key' do # CREATE another test for incorrect API Key 
      user = create(:user)
      invalid_payload = {
        origin: 'Cincinnati,OH',
        destination: 'Chicago,IL'
      }

      post '/api/v0/road_trip', params: invalid_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      expect(response.status).to eq(401)
    end
  end
end
