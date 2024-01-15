class Api::V1::MunchiesController < ApplicationController
  def search
    destination = params[:destination]
    food = params[:food]

    munchie_data = MunchiesFacade.new.munchies(destination, food)
    render json: MunchieSerializer.new(munchie_data).to_json, status: :ok
  end
end