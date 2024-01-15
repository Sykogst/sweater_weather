class MunchiesFacade
  def munchies(destination, food)
    forecast_data = ForecastFacade.new.weather_forecast(destination, 1)
    restaurant_data = YelpService.new.get_munchie(destination, food)[:businesses].first

    munchie = MunchieAttributes.new(forecast_data, restaurant_data)
  end
end