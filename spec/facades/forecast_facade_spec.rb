require 'rails_helper'

RSpec.describe ForecastFacade, type: :facade do
  describe 'Forcast Facade instance methods', :vcr do
    it '#weather_forecast' do
      forecast_facade = ForecastFacade.new
      location_param = 'denver,co'
      weather_data = forecast_facade.weather_forecast(location_param, 5)

      expect(weather_data).to be_a(Hash)
    end

  end
end