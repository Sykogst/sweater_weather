class RoadTripFacade
  def road_trip(origin, destination)
    directions_data_result = directions_data(origin, destination)
    weather_at_eta_data_result = weather_at_eta(origin, destination)
  
    RoadTrip.new(directions_data_result, weather_at_eta_data_result)
  end

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

  def weather_at_eta(origin, destination)
    lat_lon = MapService.new.get_coordinates(destination)
    forecast_data = WeatherService.new.get_forecast(lat_lon, 7) # Max for free API is 7 days out
    arrival_data = calculate_arrival_time(origin, destination)

    if arrival_data == 'Impossible Route'
      weather_at_eta = {
        datetime: arrival_data[:hour_time],
        temperature: 'Impossible Route',
        condition: 'Impossible Route'
      }
    elsif past_forecast?(forecast_data, arrival_data)
      weather_at_eta = {
        datetime: arrival_data[:hour_time],
        temperature: 'Arrival Past Last Forecast',
        condition: 'Arrival Past Last Forecast'
      }
    else
      find_hourly_forecast(forecast_data, arrival_data)
    end
  end

  def calculate_arrival_time(origin, destination)
    travel_time = directions_data(origin, destination)[:travel_time]
  
    if travel_time == 'Impossible Route'
      'Impossible Route'
    else
      travel_time_seconds = travel_time[0..1].to_i * 3600 + travel_time[3..4].to_i * 60 + travel_time[6..7].to_i
      arrival_time = Time.now + travel_time_seconds.seconds
      rounded_arrival_time = arrival_time.beginning_of_hour + ((arrival_time.min / 60).round) * 60.seconds # Rounds down

      forecastday_date = rounded_arrival_time.strftime('%Y-%m-%d')
      hour_time = rounded_arrival_time.strftime('%Y-%m-%d %H:%M')
      time_hash = { forecastday_date: forecastday_date, hour_time: hour_time }
    end
  end

  def past_forecast?(forecast_data, arrival_data)
    today_date_time = forecast_data.dig(:location, :local_time)
  
    return false unless today_date_time
  
    rounded_time = today_date_time.floor(1.hour)
    days_difference = (arrival_data[:forecastday_date] - rounded_time) / 1.day
  
    days_difference > 7
  end

  def find_hourly_forecast(forecast_data, arrival_data)
    just_date = arrival_data[:forecastday_date]
    full_date = arrival_data[:hour_time]

    forecast_daily = forecast_data[:forecast][:forecastday] # Array of hashes of Daily data, find matching one based on date
    matching_day = forecast_daily.find { |day| day[:date] == just_date }  # forecastday hash from array
    if matching_day
      matching_hour = matching_day[:hour].find { |hour| hour[:time] == full_date }
      weather_at_eta = {
        datetime: matching_hour[:time],
        temperature: matching_hour[:temp_f],
        condition: matching_hour[:condition][:text]
      }
    else
      weather_at_eta = {
        datetime: matching_hour[:time],
        temperature: 'No Weather Data',
        condition: 'No Weather Data'
      }
    end
  end
end
