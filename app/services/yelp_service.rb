class YelpService
  def conn
    Faraday.new(url: 'GET https://api.yelp.com/v3/businesses/search') do |faraday|
      faraday.header['Authorization'] = "Bearer #{Rails.application.credentials.yelp_api[:key]}"
    end
  end
end