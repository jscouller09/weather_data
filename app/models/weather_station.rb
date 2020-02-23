class WeatherStation < ActiveRecord::Base
  validates :name, presence: true
  validates :country, presence: true, format: { with: /[A-Z]{2}/ }
  validates :lat,
            numericality: { greater_than_or_equal_to: -90,
                            less_than_or_equal_to: 90 }
  validates :lon,
            numericality: { greater_than_or_equal_to: -180,
                            less_than_or_equal_to: 180 }

  OW_BASE_URL = 'http://api.openweathermap.org/data'.freeze
  OW_API_KEY = 'e81081459c34b9d603d524e60453dedf'.freeze

  def download_current_data
    # build url
    url = "#{OW_BASE_URL}/2.5/weather?id=#{args[:id]}&appid=#{OW_API_KEY}"
    # query API and return JSON
    serialised_data = URI.open(url).read
    data = JSON.parse(serialised_data, symbolize_names: true)
    # format data before returning
    format_response(data)
  end
end
