require 'rails_helper'

describe WeatherService, type: :service do
  describe 'Yelp Service instance methods', :vcr do
    it '#conn, returns a Faraday object' do
      yelp_service = YelpService.new
      expect(yelp_service.conn).to be_a(Faraday::Connection)
    end

    it '#get_munchie, returns single top rated by location and food type' do
      location = 'pueblo,co'
      food = 'italian'
      best_munchie = YelpService.new.get_munchie(location, food)

      expect(best_munchie).to be_a(Hash)
      expect(best_munchie).to have_key(:businesses)
      expect(best_munchie[:businesses].count).to eq(1)

      restaurant = best_munchie[:businesses].first
      expect(restaurant).to have_key(:name)
      expect(restaurant[:name]).to be_a(String)
      expect(restaurant).to have_key(:location)
      expect(restaurant[:location]).to be_a(Hash)
      expect(restaurant[:location]).to have_key(:display_address)
      expect(restaurant[:location][:display_address]).to be_a(Array)
      expect(restaurant).to have_key(:review_count)
      expect(restaurant[:review_count]).to be_a(Integer)
      expect(restaurant).to have_key(:rating)
      expect(restaurant[:rating]).to be_a(Float)
    end
  end
end