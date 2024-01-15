# spec/poros/munchie_attributes_spec.rb
require 'rails_helper'

RSpec.describe MunchieAttributes do
  describe '#initialize' do
    it 'creates an object with correct attributes' do
      weather_data = {
        location: { name: 'Pueblo', region: 'CO' },
        current: { temp_f: 75, condition: { text: 'Sunny' } }
      }

      yelp_data = {
        name: 'La Forchetta Da Massi',
        location: { display_address: ['126 S Union Ave, Pueblo, CO 81003'] },
        rating: 4.5,
        review_count: 148
      }

      munchie_attributes = described_class.new(weather_data, yelp_data)

      expect(munchie_attributes.destination_city).to eq('Pueblo, CO')
      expect(munchie_attributes.forecast[:summary]).to eq('Sunny')
      expect(munchie_attributes.forecast[:temperature]).to eq('75')
      expect(munchie_attributes.name).to eq('La Forchetta Da Massi')
      expect(munchie_attributes.address).to eq('126 S Union Ave, Pueblo, CO 81003')
      expect(munchie_attributes.rating).to eq(4.5)
      expect(munchie_attributes.reviews).to eq(148)
    end
  end
end
