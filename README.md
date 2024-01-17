
<a name="readme-top"></a>
<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Sykogst/sweater_weather">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

    <br />
    <a href="https://github.com/Sykogst/sweater_weather"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Sykogst/sweater_weather">View Demo</a>
    ·
    <a href="https://github.com/Sykogst/sweater_weather/issues">Report Bug</a>
    ·
    <a href="https://github.com/Sykogst/sweater_weather/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#gems">Gems</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#improvements">Improvements</a></li>
    <li><a href="#endpoints">Endpoints</a></li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project
This is the backend for an application to plan road trips. The allows users to see the current weather in addition to the forecasted weather at a destination. This is an API was built by aggregating data from multiple external APIs.


### Built With
* [![Ruby on Rails][Rails-shield]][Rails-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Gems
* [![rspec-rails][gem-rspec-rails]][gem-rspec-rails-url]
* [![simplecov][gem-simplecov]][gem-simplecov-url]
* [![factory_bot_rails][gem-factory_bot_rails]][gem-factory_bot_rails-url]
* [![faker][gem-faker]][gem-faker-url]
* [![pry][gem-pry]][gem-pry-url]
* [![shoulda-matchers][gem-shoulda-matchers]][gem-shoulda-matchers-url]
* [![faraday][gem-faraday]][gem-faraday-url]
* [![jsonapi-serializer][gem-jsonapi-serializer]][gem-jsonapi-serializer-url]
* [![capybara][gem-capybara]][gem-capybara-url]
* [![webmock][gem-webmock]][gem-webmock-url]
* [![vcr][gem-vcr]][gem-vcr-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple example steps.

### Installation

1. Get a free Weather API Key at [https://www.weatherapi.com/](https://www.weatherapi.com/) and get a MapQuest API Key at [https://developer.mapquest.com/](https://developer.mapquest.com/)

2. Clone the repo
   ```sh
   git clone https://github.com/Sykogst/sweater_weather.git
   ```
3. Enter your API
  Terminal
   ```sh
   EDITOR="code --wait" rails credentials:edit
   ```
    In editor pop up
    ```ruby
    weather_api:
      key: <YOUR API KEY>

    map_quest_api:
      key: <YOUR API KEY>
    ```
4. Gem Bundle
   ```sh
    bundle
   ```
5. Rake
   ```sh
    rails db:{drop,create,migrate,seed}
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Application Landing Page
    - [x] Retrieve weather for a city using two endpoints
      - [x] MapQuest Geocoding API to get latitude and longitude from a city and state
      - [x] Get weather forecast from Weather API using coordinates
- [x] User Registration
    - [x] POST request sent through JSON payload in body rather than query params
    - [x] Successful request creates a user in database and generates an API key
    - [x] Unsuccessful request generates a 400 level error code
          - [x] Missing email
          - [x] Email already taken
          - [x] Password Mismatch
- [x] Login
    - [x] POST request sent through JSON payload in body rather than query params
    - [x] Successful request returns user's API Key
    - [x] Unsuccessful request generates a 400 level error code, same error message for both bad credentials
          - [x] Incorrect email
          - [x] Incorrect password
- [x] Road Trip, takes origin and destination, gets weather at destination at eta
    - [x] POST request sent through JSON payload in body rather than query params
    - [x] Unsuccessful request generates a 400 level error code
          - [x] Missing API Key
          - [x] Incorrect API Key

### Improvements
- [ ] Refactor of ForecastSerializer using a PORO
- [ ] Unsure if login response is sent through body, need to revisit
- [ ] More error message handling
  - [ ] At service level if a connection is able to be made, or for valid query params
- [ ] More thorough testing, specifically error handling
- [ ] Clean up of RoadTripFacade logic
  - [ ] The `#past_forcast?` method may not be functional right now
- [ ] More Features
  - [ ] Caching of lat/lon data
  - [ ] Additional endpoints, ie images to be used by frontend

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Endpoints

### Retrieve Weather for a City
* **GET /api/v0/forecast**
  - Example Request:
    ```
    GET /api/v0/forecast?location=cincinatti,oh
    Content-Type: application/json
    Accept: application/json
    ```
  - Example Response:
    ```json
  {
      "data": {
          "id": null,
          "type": "forecast",
          "attributes": {
              "current_weather": {
                  "last_updated": "2024-01-15 12:00",
                  "temperature": -5.8,
                  "feels_like": -23.0,
                  "humidity": 77,
                  "uv": 1.0,
                  "visibility": 0.0,
                  "condition": {
                      "text": "Light snow",
                      "icon": "//cdn.weatherapi.com/weather/64x64/day/326.png"
                  }
              },
              "daily_weather": [
                  {
                      "date": "2024-01-15",
                      "sunrise": "07:20 AM",
                      "sunset": "05:00 PM",
                      "max_temp": 1.6,
                      "min_temp": -5.0,
                      "condition": {
                          "text": "Heavy snow",
                          "icon": "//cdn.weatherapi.com/weather/64x64/day/338.png"
                      }
                  },
                  {
                      "date": "2024-01-16",
                      "sunrise": "07:19 AM",
                      "sunset": "05:01 PM",
                      "max_temp": 32.4,
                      "min_temp": -3.3,
                      "condition": {
                          "text": "Sunny",
                          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                      }
                  },
                  {
                      "date": "2024-01-17",
                      "sunrise": "07:19 AM",
                      "sunset": "05:02 PM",
                      "max_temp": 33.1,
                      "min_temp": 16.5,
                      "condition": {
                          "text": "Sunny",
                          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                      }
                  },
                  {
                      "date": "2024-01-18",
                      "sunrise": "07:18 AM",
                      "sunset": "05:03 PM",
                      "max_temp": 25.8,
                      "min_temp": 13.7,
                      "condition": {
                          "text": "Patchy moderate snow",
                          "icon": "//cdn.weatherapi.com/weather/64x64/day/329.png"
                      }
                  },
                  {
                      "date": "2024-01-19",
                      "sunrise": "07:18 AM",
                      "sunset": "05:04 PM",
                      "max_temp": 29.0,
                      "min_temp": 11.3,
                      "condition": {
                          "text": "Partly cloudy",
                          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
                      }
                  }
              ],
              "hourly_weather": [
                  {
                      "time": "00:00",
                      "temperature": 6.2,
                      "condition": {
                          "text": "Partly cloudy",
                          "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
                      }...
                  }
              ]
          }
      }
    ```

### User Registration
* **POST /api/v0/users**
  - Example Request:
    ```
    POST /api/v0/users
    Content-Type: application/json
    Accept: application/json

    {
      "email": "st@email.com",
      "password": "password",
      "password_confirmation": "password"
    }
    ```
  - Example Response:
    ```json
    {
        "data": {
            "id": "1",
            "type": "user",
            "attributes": {
                "email": "st@email.com",
                "api_key": "8aa5239494504a388fa4877b7e34e6e8"
            }
        }
    }
    ```

### Login
* **POST /api/v0/sessions**
  - Example Request:
    ```
    POST /api/v0/sessions
    Content-Type: application/json
    Accept: application/json

    {
      "email": "st@email.com",
      "password": "password"
    }
    ```
  - Example Response:
    ```json
    {
        "data": {
            "type": "users",
            "id": "1",
            "attributes": {
                "email": "st@email.com",
                "api_key": "8aa5239494504a388fa4877b7e34e6e8"
            }
        }
    }
    ```

### Road Trip
* **POST /api/v0/road_trip**
  - Example Request:
    ```
    POST /api/v0/road_trip
    Content-Type: application/json
    Accept: application/json

    body:

    {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
    ```
  - Example Response:
    ```json
    {
        "data": {
            "id": null,
            "type": "road_trip",
            "attributes": {
                "start_city": "Cincinnati, OH",
                "end_city": "Chicago, IL",
                "travel_time": "04:20:56",
                "weather_at_eta": {
                    "datetime": "2024-01-17 12:00",
                    "temperature": 12.5,
                    "condition": "Overcast"
                }
            }
        }
    }
    ```


## Contributors

Sam Tran 
 
[![LinkedIn][linkedin-shield]][linkedin-url-st]
[![GitHub][github-shield-st]][github-url-st]






<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Weather-Together/weather_together_fe.svg?style=for-the-badge
[contributors-url]: https://github.com/Weather-Together/weather_together_fe/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Weather-Together/weather_together_fe.svg?style=for-the-badge
[forks-url]: https://github.com/Weather-Together/weather_together_fe/network/members
[stars-shield]: https://img.shields.io/github/stars/Weather-Together/weather_together_fe.svg?style=for-the-badge
[stars-url]: https://github.com/Weather-Together/weather_together_fe/stargazers
[issues-shield]: https://img.shields.io/github/issues/Weather-Together/weather_together_fe.svg?style=for-the-badge
[issues-url]: https://github.com/Weather-Together/weather_together_fe/issues
[license-shield]: https://img.shields.io/github/license/Weather-Together/weather_together_fe.svg?style=for-the-badge
[license-url]: https://github.com/Weather-Together/weather_together_fe/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url-st]: https://www.linkedin.com/in/sam-t-tran
[linkedin-url-kz]: https://www.linkedin.com/in/kevin-zolman
[linkedin-url-mk]: https://www.linkedin.com/in/michaelkuhlmeier
[linkedin-url-bk]: https://www.linkedin.com/in/blaine-kennedy
[linkedin-url-jo]: https://www.linkedin.com/in/john-clay-oleary
[product-screenshot]: images/screenshot.png
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[Rails-shield]: https://img.shields.io/badge/Ruby%20on%20Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Rails-url]: https://rubyonrails.org/
[HTML-shield]: https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white
[HTML-url]: https://developer.mozilla.org/en-US/docs/Web/HTML
[JavaScript-shield]: https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black
[JavaScript-url]: https://developer.mozilla.org/en-US/docs/Web/JavaScript
[PostgreSQL-shield]: https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white
[PostgreSQL-url]: https://www.postgresql.org/

[gem-debug]: https://img.shields.io/badge/debug-1.9.1-brightgreen?style=flat-square
[gem-debug-url]: https://rubygems.org/gems/debug

[gem-rspec-rails]: https://img.shields.io/badge/rspec--rails-6.1.0-green?style=flat-square
[gem-rspec-rails-url]: https://github.com/rspec/rspec-rails

[gem-simplecov]: https://img.shields.io/badge/simplecov-0.22.0-yellow?style=flat-square
[gem-simplecov-url]: https://github.com/simplecov-ruby/simplecov

[gem-factory_bot_rails]: https://img.shields.io/badge/factory_bot_rails-6.4.0-success?style=flat-square
[gem-factory_bot_rails-url]: https://github.com/thoughtbot/factory_bot_rails

[gem-faker]: https://img.shields.io/badge/faker-3.2.2-red?style=flat-square
[gem-faker-url]: https://github.com/faker-ruby/faker

[gem-pry]: https://img.shields.io/badge/pry-0.14.2-yellow?style=flat-square
[gem-pry-url]: https://github.com/pry/pry

[gem-shoulda-matchers]: https://img.shields.io/badge/shoulda--matchers-6.0.0-orange?style=flat-square
[gem-shoulda-matchers-url]: https://github.com/thoughtbot/shoulda-matchers

[gem-faraday]: https://img.shields.io/badge/faraday-2.8.1-yellowgreen?style=flat-square
[gem-faraday-url]: https://github.com/lostisland/faraday

[gem-jsonapi-serializer]: https://img.shields.io/badge/jsonapi--serializer-2.2.0-blue?style=flat-square
[gem-jsonapi-serializer-url]: https://github.com/jsonapi-serializer/jsonapi-serializer

[gem-capybara]: https://img.shields.io/badge/capybara-3.39.2-brightgreen?style=flat-square
[gem-capybara-url]: https://github.com/teamcapybara/capybara

[gem-webmock]: https://img.shields.io/badge/webmock-3.19.1-yellowgreen?style=flat-square
[gem-webmock-url]: https://github.com/bblimke/webmock

[gem-vcr]: https://img.shields.io/badge/vcr-6.2.0-orange?style=flat-square
[gem-vcr-url]: https://github.com/vcr/vcr

[github-shield-st]: https://img.shields.io/badge/GitHub-Sykogst-success?style=for-the-badge&logo=github
[github-url-st]: https://github.com/Sykogst
