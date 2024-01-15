require 'rails_helper'

describe WeatherService, type: :service do
  describe 'Weather Service instance methods', :vcr do
    it '#conn, returns a Faraday object' do
      weather_service = WeatherService.new
      expect(weather_service.conn).to be_a(Faraday::Connection)
    end

    it '#get_forecast, returns current weather, current weather data' do
      lat_lon = '39.74001,-104.99202'
      forecast_results = WeatherService.new.get_forecast(lat_lon, 5)
      current_forecast = forecast_results[:current]

      expect(forecast_results).to be_a(Hash)
      expect(forecast_results).to have_key(:current)

      expect(current_forecast).to have_key(:last_updated)
      expect(current_forecast[:last_updated]).to be_a(String)

      expect(current_forecast).to have_key(:temp_f)
      expect(current_forecast[:temp_f]).to be_a(Float)
      
      expect(current_forecast).to have_key(:feelslike_f)
      expect(current_forecast[:feelslike_f]).to be_a(Float)

      expect(current_forecast).to have_key(:humidity)
      expect(current_forecast[:humidity]).to be_a(Float).or be_a(Integer)

      expect(current_forecast).to have_key(:uv)
      expect(current_forecast[:uv]).to be_a(Float).or be_a(Integer)

      expect(current_forecast).to have_key(:vis_miles)
      expect(current_forecast[:vis_miles]).to be_a(Float).or be_a(Integer)

      expect(current_forecast).to have_key(:condition)
      expect(current_forecast[:condition][:text]).to be_a(String)
      expect(current_forecast[:condition][:icon]).to be_a(String)
    end

    it '#get_forecast, returns daily weather, next 5 day weather data' do
      lat_lon = '39.74001,-104.99202'
      forecast_results = WeatherService.new.get_forecast(lat_lon, 5)
      forecast_5day = forecast_results[:forecast][:forecastday]

      expect(forecast_5day).to be_a(Array)
      expect(forecast_5day.count).to eq(5)

      forecast_5day.each do |day|
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)

        expect(day).to have_key(:astro)
        expect(day[:astro]).to have_key(:sunrise)
        expect(day[:astro]).to have_key(:sunset)
        expect(day[:astro][:sunrise]).to be_a(String)
        expect(day[:astro][:sunset]).to be_a(String)

        expect(day).to have_key(:day)
        expect(day[:day]).to have_key(:maxtemp_f)
        expect(day[:day]).to have_key(:mintemp_f)
        expect(day[:day][:maxtemp_f]).to be_a(Float)
        expect(day[:day][:mintemp_f]).to be_a(Float)

        expect(day[:day]).to have_key(:condition)
        expect(day[:day][:condition]).to have_key(:text)
        expect(day[:day][:condition]).to have_key(:icon)
        expect(day[:day][:condition][:text]).to be_a(String)
        expect(day[:day][:condition][:icon]).to be_a(String)
  
        expect(day).to have_key(:hour)
        expect(day[:hour]).to be_a(Array)

        hourly_weather = day[:hour]
        hourly_weather.each do |hour|
          expect(hour).to have_key(:time)
          expect(hour[:time]).to be_a(String) # Parse out last five of string

          expect(hour).to have_key(:temp_f)
          expect(hour[:temp_f]).to be_a(Float)

          expect(hour).to have_key(:condition)
          expect(hour[:condition]).to have_key(:text)
          expect(hour[:condition]).to have_key(:icon)
          expect(hour[:condition][:text]).to be_a(String)
          expect(hour[:condition][:icon]).to be_a(String)
        end
      end
    
    end
  end
end