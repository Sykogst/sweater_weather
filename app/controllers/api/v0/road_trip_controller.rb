class Api::V0::RoadTripController < ApplicationController
  def create
    payload = JSON.parse(request.body.read, symbolize_names: true)
    origin = payload[:origin]
    destination = payload[:destination]
    api_key = payload[:api_key]

    road_trip_data = RoadTripFacade.new(origin, destination, api_key)
    render json: RoadTripSerializer.new(munchie_data).to_json, status: :ok
  end
end
