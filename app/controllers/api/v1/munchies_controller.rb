class Api::V1::MunchiesController < ApplicationController
  def weather_forecast
    desitination = params[:desitination]
    food = params[:food]

    # render json: ForecastSerializer.new(forecast_data).to_json, status: :ok
  end
end