class MunchieSerializer
  def initialize(road_trip_data)
    @data = road_trip_data
  end

  def to_json
    {
      data: {
        id: nil,
        type: 'road_trip',
        attributes: {
          start_city: @data.start_city,
          end_city: @data.end_city,
          travel_time: @data.travel_time,
          weather_at_eta: @data.weather_at_eta
        }
      }
    }
  end
end