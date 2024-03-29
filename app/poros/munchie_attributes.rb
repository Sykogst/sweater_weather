class MunchieAttributes
  attr_reader :address,
              :destination_city,
              :forecast,
              :name,
              :rating,
              :reviews

  def initialize(weather_data, yelp_data)
    @destination_city = "#{weather_data[:location][:name]}, #{weather_data[:location][:region]}"
    @forecast = {
      summary: weather_data[:current][:condition][:text],
      temperature: weather_data[:current][:temp_f].to_s
    }
    @name = yelp_data[:name]
    @address = yelp_data[:location][:display_address].first
    @rating = yelp_data[:rating]
    @reviews = yelp_data[:review_count]
  end
end