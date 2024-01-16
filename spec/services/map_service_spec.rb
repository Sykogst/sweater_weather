require 'rails_helper'

describe MapService, type: :service do
  describe 'Map Service instance methods', :vcr do
    it '#conn, returns a Faraday object' do
      map_service = MapService.new
      expect(map_service.conn).to be_a(Faraday::Connection)
    end

    it '#get_coordinates, returns coordinates parsed' do
      location = 'denver,co'
      coordinate_results = MapService.new.get_coordinates(location)

      expect(coordinate_results).to be_a(String)
      expect(coordinate_results).to eq('39.74001,-104.99202')
    end

    it '#get_directions, returns directions data from origin to destination' do
      origin = 'denver,co'
      destination = 'boulder,co'
      direction_results = MapService.new.get_coordinates(location)

      expect(direction_results).to be_a(Hash)
    end
  end
end
