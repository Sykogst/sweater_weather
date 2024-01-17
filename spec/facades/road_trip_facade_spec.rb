require 'rails_helper'

RSpec.describe RoadTripFacade, type: :facade do
  describe 'RoadTrip Facade instance methods' do
    it '#directions_data, returns hash of directions data, good search', :vcr do
      origin = 'denver,co'
      destination = 'boulder,co'
      directions_data = RoadTripFacade.new.directions_data(origin, destination)

      expect(directions_data).to be_a(Hash)
      expect(directions_data[:start_city]).to  be_a(String)
      expect(directions_data[:end_city]).to be_a(String)
      expect(directions_data[:travel_time]).to be_a(String)
      expect(directions_data[:travel_time]).to_not eq('Impossible Route')
    end

    it '#directions_data, returns hash of directions data, bad search', :vcr do
      origin = 'denver,co'
      destination = 'london'
      directions_data = RoadTripFacade.new.directions_data(origin, destination)

      expect(directions_data).to be_a(Hash)
      expect(directions_data[:start_city]).to eq(origin)
      expect(directions_data[:end_city]).to eq(destination)
      expect(directions_data[:travel_time]).to eq('Impossible Route')
    end

    it '#calculate_arrival_time, returns arrival time' do
      origin = 'denver,co'
      destination = 'boulder,co'
      facade = RoadTripFacade.new
    
      allow(facade).to receive(:directions_data).with(origin, destination).and_return({
        start_city: 'Denver, CO',
        end_city: 'Boulder, CO',
        travel_time: '02:30:00'
      })
    
      current_time = Time.new(2024, 1, 28, 12, 0, 0)
      allow(Time).to receive(:now).and_return(current_time)

      expected_arrival_time = current_time + 2.hours + 30.minutes
      arrival_time = facade.calculate_arrival_time(origin, destination)

      expect(arrival_time[:forecastday_date]).to eq('2024-01-28')
      expect(arrival_time[:hour_time]).to eq('2024-01-28 14:00')
    end

    it '#weather_at_eta, returns weather data', :vcr do
      origin = 'denver,co'
      destination = 'boulder,co'
      facade = RoadTripFacade.new
      current_time = Time.now.floor(1.hour).strftime('%Y-%m-%d %H:%M')

      weather_at_eta = facade.weather_at_eta(origin, destination)
      expect(weather_at_eta[:datetime]).to be_present
      expect(weather_at_eta[:temperature]).to be_present
      expect(weather_at_eta[:condition]).to be_present
    end

    it '#past_forecast?, returns true if arrival time is more than 7 days from current time' do
      facade = RoadTripFacade.new
      current_time = Time.now
      forecast_data = { location: { local_time: current_time } }
      arrival_data = { forecastday_date: (current_time + 8.days).to_time }
      past_forecast = facade.past_forecast?(forecast_data, arrival_data)
      expect(past_forecast).to eq(true)
    end
    
    it '#past_forecast?, returns false if arrival time is within 7 days from current time' do
      facade = RoadTripFacade.new
      current_time = Time.now
      forecast_data = { location: { local_time: current_time } }
      arrival_data = { forecastday_date: (current_time + 6.days).to_time } # Convert to Time
      past_forecast = facade.past_forecast?(forecast_data, arrival_data)
      expect(past_forecast).to eq(false)
    end

    it '#road_trip, returns a RoadTrip object with directions and weather data', :vcr do
      origin = 'denver,co'
      destination = 'boulder,co'
      road_trip = RoadTripFacade.new.road_trip(origin, destination)
    
      expect(road_trip).to be_a(RoadTrip)
    end
  end
end
