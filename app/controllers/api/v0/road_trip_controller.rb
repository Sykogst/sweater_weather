class Api::V0::RoadTripController < ApplicationController
  before_action :authenticate_api_key

  def create
    # QUESTION: Does using request body over params[:origin], etc ensure only json payload in body can be used?
    payload = JSON.parse(request.body.read, symbolize_names: true)
    origin = payload[:origin]
    destination = payload[:destination]

    road_trip_data = RoadTripFacade.new.road_trip(origin, destination)
    render json: RoadTripSerializer.new(road_trip_data).to_json, status: :ok
  end

  private

  def authenticate_api_key
    payload = JSON.parse(request.body.read, symbolize_names: true)
    api_key = payload[:api_key]

    if api_key.nil?
      render json: { error: 'Unauthorized - Missing API key' }, status: :unauthorized
    else
      user = User.find_by(api_key: api_key)
      if user.nil?
        render json: { error: 'Unauthorized - Invalid API key' }, status: :unauthorized
      end
    end
  end
end
