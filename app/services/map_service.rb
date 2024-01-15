class MapService
  def conn
    Faraday.new(url: 'https://www.mapquestapi.com/geocoding/v1/') do |faraday|
      faraday.params['key'] = Rails.application.credentials.map_quest_api
    end
  end

  def get_coordinates(location)
    response = conn.get do |request|
      request.url('/address')
      request.params['location'] = location
    end
    data = JSON.parse(response.body, symbolize_names: true)
    parse_coordinates(data)
  end
  
  def parse_coordinates(data)
    coordinates = data[:results].first[:locations].first[:latLing]
    lat_lon = "#{coordinates[:lat]},#{coordinates[:lon]}"
  end

  private
  
end