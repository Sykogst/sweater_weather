class RoadTripFacade
  def directions_data(origin, destination)
    directions = MapService.new.get_directions(origin, destination)
    locations = directions[:route][:locations]

    if directions[:route].key?(:routeError)
      directions_data = {
        start_city: origin,
        end_city: destination,
        travel_time: 'Impossible Route'
      }
    else
      directions_data = {
        start_city: "#{locations.first[:adminArea5]}, #{locations.first[:adminArea3]}",
        end_city: "#{locations.last[:adminArea5]}, #{locations.last[:adminArea3]}",
        travel_time: directions[:route][:formattedTime]
      }
    end
  end
end