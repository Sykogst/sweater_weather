class MapService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com/") do |faraday|
      faraday.params['key'] = Rails.application.credentials.map_quest_api[:key]
    end
  end

  def get_coordinates(location)
    response = conn.get do |request|
      request.url('geocoding/v1/address')
      request.params['location'] = location
    end
    data = JSON.parse(response.body, symbolize_names: true)
    parse_coordinates(data)
  end

  def get_directions(origin, destination)
    # directions/v2/route?key=KEY&from=denver,co&to=boulder,co
    response = conn.get do |request|
      request.url('directions/v2/route')
      request.params[:from] = origin
      request.params[:to] = destination
    end
    data = JSON.parse(response.body, symbolize_names: true)
  end

  
  private
  # REFACTOR: MAYBE add some error messaging for making sure API conn made to MapQuest
  def parse_coordinates(data) 
    coordinates = data[:results].first[:locations].first[:latLng]
    lat_lon = "#{coordinates[:lat]},#{coordinates[:lng]}"
  end
end
