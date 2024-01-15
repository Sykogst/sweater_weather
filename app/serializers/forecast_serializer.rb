class ForecastSerializer
  def initialize(forecast)
    @forecast = forecast
  end

  def to_json
    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: {
            last_updated: @forecast[:current][:last_updated],
            temperature: @forecast[:current][:temp_f],
            feels_like: @forecast[:current][:feelslike_f],
            humidity: @forecast[:current][:humidity],
            uv: @forecast[:current][:uv],
            visibility: @forecast[:current][:vis_miles],
            condition: {
              text: @forecast[:current][:condition][:text],
              icon: @forecast[:current][:condition][:icon]
            }
          },
          daily_weather: @forecast[:forecast][:forecastday].map do |day|
            {
              date: day[:date],
              sunrise: day[:astro][:sunrise],
              sunset: day[:astro][:sunset],
              max_temp: day[:day][:maxtemp_f],
              min_temp: day[:day][:mintemp_f],
              condition: {
                text: day[:day][:condition][:text],
                icon: day[:day][:condition][:icon]
              }
            }
          end,
          hourly_weather: @forecast[:forecast][:forecastday][0][:hour].map do |hour|
            {
              time: hour[:time][-5..-1],
              temperature: hour[:temp_f],
              condition: {
                text: hour[:condition][:text],
                icon: hour[:condition][:icon]
              }
            }
          end
        }
      }
    }
  end
end