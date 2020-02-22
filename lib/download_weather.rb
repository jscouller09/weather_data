# These functions make use of the OpenWeather API
# the end goal is to return current temp, RH, windspeed and cloud-cover info
# search by lat/long coordinates or by city name

# imports
require 'json'
require 'open-uri'
require 'pry-byebug'

OW_API_KEY = "e81081459c34b9d603d524e60453dedf"
OW_BASE_URL = "http://api.openweathermap.org/data"
CITIES = JSON.parse(File.read('city_data_hash.json'), symbolize_names: true)

def find_city(country="", city="")
  # assume country code is right
  cities = CITIES[country.to_sym]
  # find possible matches for city name (case insensitive)
  matches = cities.keys.select do |name|
    name.to_s.downcase =~ /.*#{city.downcase}.*/
  end
  # return the city data (as array of hashes) for all matches
  data = []
  matches.each do |match|
    cities[match].each { |entry| data << entry.merge({ name: match.to_s }) }
  end
  data
end

def format_response(data = {})
  data[:weather]
end

def download_current_by_city(args = {})
  return [] if args[:id].nil?
  url = "#{OW_BASE_URL}/2.5/weather?id=#{args[:id]}&appid=#{OW_API_KEY}"
  data = JSON.parse(URI.open(url).read, symbolize_names: true)
end

def download_forecast_by_city(args = {})

end

def download_current_by_loc(args = {})

end

def download_forecast_by_loc(args = {})

end





# tests
chc_stns = find_city("NZ", "Christchurch")
ash_stns = find_city("NZ", "ashburton")

chc_current = download_current_by_city(chc_stns.first)
p chc_stns.first
p chc_current
