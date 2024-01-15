class WeatherService
  def conn
    Faraday.new(url: 'http://api.weatherapi.com/v1') do |faraday|
      faraday.params['key'] = Rails.application.credentials.weather_api
    end
  end

  def get_forecast(lat_lon, days)
    response = conn.get do |request|
      request.url('/forecast.json')
      request.params['q'] = lat_lon
      request.params['days'] = days
    end
  end
end
