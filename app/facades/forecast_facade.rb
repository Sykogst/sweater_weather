class WeatherFacade
  def get_forecast(location)
    lat_lon = MapService.get_coordinates(location)
    forcast_data = WeatherService.get_forecast(lat_lon)
  end


end