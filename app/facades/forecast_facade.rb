class ForecastFacade
  def weather_forecast(location, days)
    lat_lon = MapService.get_coordinates(location)
    forecast_data = WeatherService.get_forecast(lat_lon, days)
  end
end
