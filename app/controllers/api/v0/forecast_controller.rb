class Api::V0::ForecastController < ApplicationController
  def weather_forecast
    location = params[:location]
    days = 5

    forecast_data = ForecastFacade.new.weather_forecast(location, days)

    render json: ForecastSerializer.new(forecast_data).to_json, status: :ok
  end
end