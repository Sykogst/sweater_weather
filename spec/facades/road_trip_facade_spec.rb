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
  end
end