require 'rails_helper'

RSpec.describe RoadTrip do
  describe '#initialize' do
    it 'creates an object with correct attributes' do
      direction_data = {
        start_city: 'Denver, CO',
        end_city: 'Boulder, CO',
        travel_time: '02:30:00'
      }

      weather_data = {
        datetime: '2024-01-28 14:00',
        temperature: 45.5,
        condition: 'Partly Cloudy'
      }

      road_trip = RoadTrip.new(direction_data, weather_data)

      expect(road_trip.start_city).to eq('Denver, CO')
      expect(road_trip.end_city).to eq('Boulder, CO')
      expect(road_trip.travel_time).to eq('02:30:00')
      expect(road_trip.weather_at_eta[:datetime]).to eq('2024-01-28 14:00')
      expect(road_trip.weather_at_eta[:temperature]).to eq(45.5)
      expect(road_trip.weather_at_eta[:condition]).to eq('Partly Cloudy')
    end
  end
end
