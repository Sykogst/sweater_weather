require 'rails_helper'

RSpec.describe 'Road trip based on json payload in body', type: :request do
  describe 'POST /api/v0/road_trip' do
    it 'creates a new road trip and returns the expected response' do
      valid_payload = {
        origin: 'Cincinnati,OH',
        destination: 'Chicago,IL',
        api_key: api_key
      }

      post '/api/v0/road_trip', body: valid_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to have_key(:data)
      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_nil
      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('roadtrip')
      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to have_key(:start_city)
      expect(data[:data][:attributes]).to have_key(:end_city)
      expect(data[:data][:attributes]).to have_key(:travel_time)
      expect(data[:data][:attributes]).to have_key(:weather_at_eta)
    end

    it 'returns 401 Unauthorized, missing API Key' do # CREATE test for missing API Key also
      invalid_payload = {
        origin: 'Cincinnati,OH',
        destination: 'Chicago,IL'
      }

      post '/api/v0/road_trip', body: invalid_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response.status).to eq(401)
    end
  end
end
