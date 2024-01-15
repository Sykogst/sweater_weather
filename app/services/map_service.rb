class MapService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/") do |faraday|
      faraday.params['key'] = Rails.application.credentials.map_quest_api[:key]
    end
  end

  def get_coordinates(location)
    response = conn.get do |request|
      request.url('address')
      request.params['location'] = location
    end
    data = JSON.parse(response.body, symbolize_names: true)
    parse_coordinates(data)
  end
  
  private
  # REFACTOR: MAYBE add some error messaging for making sure API conn made to MapQuest
  def parse_coordinates(data) 
    coordinates = data[:results][0][:locations][0][:latLng]
    lat_lon = "#{coordinates[:lat]},#{coordinates[:lng]}"
  end
end
