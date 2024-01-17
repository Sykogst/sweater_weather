require 'rails_helper'

RSpec.describe RoadTripSerializer, type: :serializer do
  it 'serializes road trip data to the correct JSON format' do
    direction_data = {
      start_city: 'Cincinatti, OH',
      end_city: 'Chicago, IL',
      travel_time: '04:40:45'
    }

    weather_data = {
      datetime: '2023-04-07 23:00',
      temperature: 44.2,
      condition: 'Cloudy with a chance of meatballs'
    }

    road_trip = RoadTrip.new(direction_data, weather_data)
    serializer = RoadTripSerializer.new(road_trip)

    expected_json = {
      data: {
        id: nil,
        type: 'road_trip',
        attributes: {
          start_city: 'Cincinatti, OH',
          end_city: 'Chicago, IL',
          travel_time: '04:40:45',
          weather_at_eta: {
            datetime: '2023-04-07 23:00',
            temperature: 44.2,
            condition: 'Cloudy with a chance of meatballs'
          }
        }
      }
    }

    expect(serializer.to_json).to eq(expected_json)
  end
end