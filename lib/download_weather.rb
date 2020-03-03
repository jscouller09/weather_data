# These functions make use of the OpenWeather API
# the end goal is to return current temp, RH, windspeed and cloud-cover info
# search by lat/long coordinates or by city id

# imports
require 'json'
require 'open-uri'
require 'pry-byebug'

OW_API_KEY = ''.freeze
OW_BASE_URL = 'http://api.openweathermap.org/data'.freeze

def format_response(data = {})
  data[:weather]
end

def download_current_by_city(args = {})
  return [] if args[:id].nil?

  # build url
  url = "#{OW_BASE_URL}/2.5/weather?id=#{args[:id]}&appid=#{OW_API_KEY}"

  # query API and return JSON
  serialised_data = URI.open(url).read
  data = JSON.parse(serialised_data, symbolize_names: true)

  # format data before returning
  format_response(data)
end

# tests
chc_stn = { id: 7_910_036, lon: 172.745865, lat: -43.645779,
            name: 'Christchurch City', country: 'NZ' }
chc_current = download_current_by_city(chc_stn)
p chc_stn
p chc_current
