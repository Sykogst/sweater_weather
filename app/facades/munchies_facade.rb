class MunchiesFacade
  def munchies(destination, food)
    forecast_data = ForecastFacade.new.weather_forecast(destination, 1)
    restaurant_data = YelpService.new.get_munchies(destination, food)
  end
end