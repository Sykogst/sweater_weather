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
      expect(coordinate_results).to eq('39.7400,-104.99202')
    end
  end
end
