require 'rails_helper'

RSpec.describe RoadTripFacade, type: :facade do
  describe 'RoadTrip Facade instance methods', :vcr do
    it '#directions_data, returns hash of directions data, good search' do
      origin = 'denver,co'
      destination = 'boulder,co'
      directions_data = RoadTripFacade.new.directions_data(origin, destination)

      expect(directions_data).to be_a(Hash)
      expect(directions_data[:start_city]).to eq('Denver, CO')
      expect(directions_data[:end_city]).to eq('Boulder, CO')
      expect(directions_data[:travel_time]).to be_a(String)
      expect(directions_data[:travel_time]).to_not eq('Impossible Route')
    end

    it '#directions_data, returns hash of directions data, bad search' do
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
  end
end