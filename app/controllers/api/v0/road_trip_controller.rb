class Api::V0::RoadTripController < ApplicationController
  def create
    payload = JSON.parse(request.body.read, symbolize_names: true)
    api_key = payload[:api_key]
    origin = payload[:origin]
    destination = payload[:destination]

    road_trip_data = RoadTripFacade.new(api_key, origin, destination)
    render json: RoadTripSerializer.new(munchie_data).to_json, status: :ok
  end
end
