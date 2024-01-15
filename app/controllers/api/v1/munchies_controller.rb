class Api::V1::MunchiesController < ApplicationController
  def search
    destination = params[:destination]
    food = params[:food]

    munchies_data = MunchiesFacade.new.munchies(destination, food)
    render json: MunchiesSerializer.new(munchies_data).to_json, status: :ok
  end
end