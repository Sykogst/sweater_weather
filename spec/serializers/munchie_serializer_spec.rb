require 'rails_helper'

RSpec.describe MunchieSerializer, type: :serializer do
  it 'serializes the Munchie object to the correct JSON format' do
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

    munchie_attributes = MunchieAttributes.new(weather_data, yelp_data)

    expected_forecast = {
      summary: weather_data[:current][:condition][:text],
      temperature: weather_data[:current][:temp_f].to_s
    }

    expected_json = {
      data: {
        id: nil,
        type: 'munchie',
        attributes: {
          destination_city: 'Pueblo, CO',
          forecast: expected_forecast,
          restaurant: { name: 'La Forchetta Da Massi', address: '126 S Union Ave, Pueblo, CO 81003', rating: 4.5, reviews: 148 }
        }
      }
    }

    expect(MunchieSerializer.new(munchie_attributes).to_json).to eq(expected_json)
  end
end
