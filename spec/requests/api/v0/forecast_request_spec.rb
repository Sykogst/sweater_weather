require 'rails_helper'

describe 'Get weather for a city', type: :request do
  describe 'GET /api/v0/forecast?location=city,st', :vcr do
    before(:each) do
      @location_params = { location: 'denver,co' }
      @invalid_location_params = { location: 'denver,cooooo' }
    end

    it 'returns a successful response, 200, for a valid location' do
      get '/api/v0/forecast', params: @location_params
      expect(response.status).to eq(200)
    end

    it 'returns forecast data for location upon successful response' do
      get '/api/v0/forecast', params: { location: @location_params }
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:data)
      expect(data[:data]).to have_key(:id)
      expect(data[:data]).to have_key(:type)
      expect(data[:data]).to have_key(:attributes)

      attributes = data[:data][:attributes]

      expect(attributes).to have_key(:current_weather)
      expect(attributes[:current_weather]).to have_key(:last_updated)
      expect(attributes[:current_weather]).to have_key(:temperature)
      expect(attributes[:current_weather]).to have_key(:feels_like)
      expect(attributes[:current_weather]).to have_key(:humidity)
      expect(attributes[:current_weather]).to have_key(:uv)
      expect(attributes[:current_weather]).to have_key(:visibility)
      expect(attributes[:current_weather]).to have_key(:condition)
      expect(attributes[:current_weather][:condition]).to have_key(:text)
      expect(attributes[:current_weather][:condition]).to have_key(:icon)

      expect(attributes).to have_key(:daily_weather)
      expect(attributes[:daily_weather]).to be_an(Array)
      expect(attributes[:daily_weather].size).to eq(5)
      attributes[:daily_weather].each do |day|
        expect(day).to have_key(:date)
        expect(day).to have_key(:sunrise)
        expect(day).to have_key(:sunset)
        expect(day).to have_key(:max_temp)
        expect(day).to have_key(:min_temp)
        expect(day).to have_key(:condition)
        expect(day[:condition]).to have_key(:text)
        expect(day[:condition]).to have_key(:icon)
      end

      expect(attributes).to have_key(:hourly_weather)
      expect(attributes[:hourly_weather]).to be_an(Array)
      expect(attributes[:hourly_weather].size).to eq(24)
      attributes[:hourly_weather].each do |hour|
        expect(hour).to have_key(:time)
        expect(hour).to have_key(:temperature)
        expect(hour).to have_key(:condition)
        expect(hour[:condition]).to have_key(:text)
        expect(hour[:condition]).to have_key(:icon)
      end
    end

    xit 'returns an unsuccessful response, 404, for an invalid location' do
      get '/api/v0/forecast', params: @invalid_location_params
      expect(response.status).to eq(404)
    
      error_response = JSON.parse(response.body, symbolize_names: true)
      expect(error_response).to have_key(:error)
      expect(error_response[:error]).to eq('Location not found')
    end
  end
end