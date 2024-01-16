class Api::V0::RoadTripController < ApplicationController
  def create
    # QUESTION: Does using request body over params[:origin], etc ensure only json payload in body can be used?
    payload = JSON.parse(request.body.read, symbolize_names: true)
    origin = payload[:origin]
    destination = payload[:destination]
    api_key = payload[:api_key]

    road_trip_data = RoadTripFacade.new(origin, destination, api_key)
    render json: RoadTripSerializer.new(munchie_data).to_json, status: :ok
  end
end
