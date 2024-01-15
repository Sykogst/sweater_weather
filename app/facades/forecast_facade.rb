class ForecastFacade
  def weather_forecast(location, days)
    lat_lon = MapService.new.get_coordinates(location)
    forecast_data = WeatherService.new.get_forecast(lat_lon, days)
  end
end
