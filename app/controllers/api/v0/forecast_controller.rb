class Api::V0::ForecastController < ApplicationController
  def weather_forecast
    location = params[:location]
    
    forecast_data = ForecastFacade.new.weather_forecast(location, 5)

    render json: ForecastSerializer.new(forecast_data).serializable_hash, status: :ok
  end
end