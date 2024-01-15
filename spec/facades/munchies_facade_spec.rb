require 'rails_helper'

RSpec.describe MunchiesFacade, type: :facade do
  describe 'Munchies Facade instance methods', :vcr do
    it '#munchies' do
      destination_param = 'pueblo,co'
      food_param = 'italian'
   
      munchies_facade = MunchiesFacade.new
      munchie = munchies_facade.munchies(destination_param, food_param)

      expect(munchie).to be_a(MunchieAttributes)

      expect(munchie).to respond_to(:address)
      expect(munchie).to respond_to(:destination_city)
      expect(munchie).to respond_to(:forecast)
      expect(munchie).to respond_to(:name)
      expect(munchie).to respond_to(:rating)
      expect(munchie).to respond_to(:reviews)
    end
  end
end