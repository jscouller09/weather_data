# imports
require 'json'
require 'pry-byebug'

# read city list info downloaded from => http://bulk.openweathermap.org/sample/
CITY_INFO = JSON.parse(File.read('city.list.json'))

# organise city data as hash: country => city => [{ relevant_data }]
# some cities have multiple ids at different coordinates
# therefore arrays under each city have >= 1 entry
# { IT: { "Livo": [{ id: 707860, lat: 44.549999, lon: 34.2833333 },
#                  { id: 707860, lat: 44.549999, lon: 34.2833333 }] } }
CITY_DATA_HASH = Hash.new
CITY_INFO.each do |city|
  # get the current city and it's id/lat/long as a hash
  country = city["country"].to_sym
  city_name = city["name"]
  new_city = Hash.new
  new_city[city_name] = [{ id: city["id"],
                           lon: city["coord"]["lon"],
                           lat: city["coord"]["lat"] }]
  # check if we have any existing data for this country
  existing_cities = CITY_DATA_HASH[country] || {}
  # merge the existing data with the new data
  existing_cities.merge!(new_city) do |key, fv, nv|
    # if the city name already exits for this country, append to array
    puts "Duplicate city for #{country}: #{key} -> #{fv.count + 1} repeats"
    fv << nv.first
  end
  # update the city data hash
  CITY_DATA_HASH[country] = existing_cities
end

# dump output to JSON
file_name = 'city_data_hash.json'
open(file_name, 'wb') do |f|
  f.puts JSON.pretty_generate(CITY_DATA_HASH)
end
puts "Wrote data to: #{file_name}"
