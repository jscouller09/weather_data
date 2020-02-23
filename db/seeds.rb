require 'json'
require 'pry-byebug'
require_relative '../app/models/weather_station'

# read city list info downloaded from => http://bulk.openweathermap.org/sample/
CITY_INFO = JSON.parse(File.read('data/city.list.json'), symbolize_names: true)

# iterate over station list and create WeatherStation instances
invalid_stations = []
counter = 0
last_progress = 0
num_stations = CITY_INFO.length
CITY_INFO.each do |station|
  station.merge!(station[:coord])
  station.delete(:coord)
  new_station = WeatherStation.new(station)
  invalid_stations << station unless new_station.save
  counter += 1
  progress = (counter.fdiv(num_stations) * 100.0).round
  puts "#{progress}\% complete" unless progress == last_progress
  last_progress = progress
end

# print invalid stations list at the end
puts 'The following stations were invalid and not added to the DB...'
invalid_stations.each { |stn| puts stn }
