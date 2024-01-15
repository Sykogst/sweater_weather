class MunchiesFacade
  def munchies(destination, food)
    forecast_data = ForecastFacade.new.weather_forecast(destination, 1)
    restaurant_data = YelpService.new.get_munchies(destination, food)[:businesses].first

    munchie = MunchieAttributes.new(forecast_data, restaurant_data)
  end
end