class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(direction_data, weather_data)
    @start_city = direction_data[:start_city]
    @end_city = direction_data[:end_city]
    @travel_time = direction_data[:travel_time]
    @weather_at_eta = {
      datetime: weather_data[:datetime],
      temperature: weather_data[:temperature],
      condition: weather_data[:condition]
    }
  end
end
