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



  def calculate_arrival_time(origin, destination)
    travel_time = directions_data(origin, destination)[:travel_time]
  
    if travel_time == 'Impossible Route'
      'Impossible Route'
    else
      travel_time_seconds = travel_time[0..1].to_i * 3600 + travel_time[3..4].to_i * 60 + travel_time[6..7].to_i
      current_time = Time.now
  
      # Rounds down
      arrival_time = current_time + travel_time_seconds.seconds
      rounded_arrival_time = arrival_time.beginning_of_hour + ((arrival_time.min / 60).round) * 60.seconds
      format_rounded_time = rounded_arrival_time.strftime("%Y-%m-%d %H:%M")
    end
  end
end