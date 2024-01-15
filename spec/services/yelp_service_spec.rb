require 'rails_helper'

describe WeatherService, type: :service do
  describe 'Yelp Service instance methods', :vcr do
    it '#conn, returns a Faraday object' do
      yelp_service = YelpService.new
      expect(yelp_service.conn).to be_a(Faraday::Connection)
    end
  end
end