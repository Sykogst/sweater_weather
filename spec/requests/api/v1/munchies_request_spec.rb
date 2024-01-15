require 'rails_helper'

describe 'Get food and forcast information for desination city', type: :request do
  describe '/api/v1/munchies?destination=pueblo,co&food=italian', :vcr do
    it 'returns a successful response, 200, for valid params' do
      munchies_params = { destination: 'pueblo,co', food: 'italian'}
      get '/api/v1/munchies', params: munchies_params
  
      expect(response.status).to eq(200)
    end

  end
end