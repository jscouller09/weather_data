class CreateWeatherStations < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_stations do |t|
      t.string :country
      t.string :name
      t.float :lat
      t.float :lon
      t.timestamps # add 2 columns, `created_at` and `updated_at`
    end
  end
end
