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
  end
end