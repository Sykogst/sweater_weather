require 'rails_helper'

RSpec.describe ForecastSerializer, type: :serializer do
  describe 'Serializing' do
    it 'serializes forecast data to the correct JSON format' do
      weather_data = {
        current: {
          last_updated: '2022-01-16 12:00',
          temp_f: 72.5,
          feelslike_f: 75.0,
          humidity: 60,
          uv: 3,
          vis_miles: 10.0,
          condition: {
            text: 'Partly Cloudy',
            icon: 'https://example.com/partly-cloudy.png'
          }
        },
        forecast: {
          forecastday: [
            {
              date: '2022-01-17',
              astro: {
                sunrise: '07:00',
                sunset: '17:00'
              },
              day: {
                maxtemp_f: 80.0,
                mintemp_f: 65.0,
                condition: {
                  text: 'Sunny',
                  icon: 'https://example.com/sunny.png'
                }
              },
              hour: [
                {
                  time: '2022-01-17 12:00',
                  temp_f: 75.0,
                  condition: {
                    text: 'Sunny',
                    icon: 'https://example.com/sunny.png'
                  }
                },
                # Add more hourly data as needed
              ]
            }
          ]
        }
      }

      expected_json = {
        data: {
          id: nil,
          type: 'forecast',
          attributes: {
            current_weather: {
              last_updated: '2022-01-16 12:00',
              temperature: 72.5,
              feels_like: 75.0,
              humidity: 60,
              uv: 3,
              visibility: 10.0,
              condition: {
                text: 'Partly Cloudy',
                icon: 'https://example.com/partly-cloudy.png'
              }
            },
            daily_weather: [
              {
                date: '2022-01-17',
                sunrise: '07:00',
                sunset: '17:00',
                max_temp: 80.0,
                min_temp: 65.0,
                condition: {
                  text: 'Sunny',
                  icon: 'https://example.com/sunny.png'
                }
              }
            ],
            hourly_weather: [
              {
                time: '12:00',
                temperature: 75.0,
                condition: {
                  text: 'Sunny',
                  icon: 'https://example.com/sunny.png'
                }
              }
              # Only one hour for now
            ]
          }
        }
      }

      expect(ForecastSerializer.new(weather_data).to_json).to eq(expected_json)
    end
  end
end
