class YelpService
  def conn
    Faraday.new(url: 'https://api.yelp.com/v3/') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{Rails.application.credentials.yelp_api[:key]}"
    end
  end

  def get_munchie(location, food)
    # location=pueblo,co&food=italian&sort_by=rating&limit=1
    response = conn.get do |request|
      request.url('businesses/search')
      request.params['location'] = location
      request.params['food'] = food
      request.params['sort_by'] = 'rating'
      request.params['limit'] = 1
    end

    data = JSON.parse(response.body, symbolize_names: true)
  end
end