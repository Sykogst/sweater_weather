require 'rails_helper'

RSpec.describe MunchiesFacade, type: :facade do
  describe 'Munchies Facade instance methods', :vcr do
    it '#munchies' do
      munchies_facade = MunchiesFacade.new
      destination_param = 'denver,co'
      weather_data = forecast_facade.weather_forecast(location_param, 1)

      expect(weather_data).to be_a(Hash)
    end

  end
end