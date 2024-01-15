require 'rails_helper'

RSpec.describe ForecastSerializer, type: :serializer do
  describe 'Serializing', :vcr do
    xit '#to_json' do
      location = 'denver,co'
      weather_data = ForecastFacade.new.weather_forecast(location, 1)

      weather_data_serialized = ForecastSerializer.new(weather_data).to_json
      
      # Need to filter out data more before serializing and testing more
    end
  end
end