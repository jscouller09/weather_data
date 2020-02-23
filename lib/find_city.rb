require 'json'

COUNTRIES = JSON.parse(File.read('data/city_data_hash.json'),
                       symbolize_names: true)

def find_city(country = '', city = '')
  # assume country code is right
  cities = COUNTRIES[country.to_sym]
  # find possible matches for city name (case insensitive)
  matches = cities.keys.select do |name|
    name.to_s.downcase =~ /.*#{city.downcase}.*/
  end
  # return the city data (as array of hashes) for all matches
  data = []
  matches.each do |match|
    cities[match].each { |entry| data << entry.merge(name: match.to_s) }
  end
  data
end

# tests
p find_city('NZ', 'Christchurch')
p find_city('NZ', 'ashburton')
